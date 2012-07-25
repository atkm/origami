#!/usr/bin/env ruby
### definition_seed_builder.rb
### Input: Distro, version, arch, and type
###   e.g. 'CentOS-5-32-typeA definition'

### What it does:
### 1. Lookup os_type_id.yml, iso_file.yml, boot_cmd_sequence.yml,
###    and kickstart_file.yml (note, these names correspond to
###    options in ks.cfg), OR reponame.yml and pkgs.yml
###    depending on the instruction.
### 2. Get values from those hases.
### 3. Create a seed file and spit it out.

### Output: the seed file content.

### This is a test (need to expand it to preseed and autoyast)
### hence note the following:
### - Supports only CentOS-[5,6]-[32,64]-[typeA,typeB]
### and RedHat-6-64-[typeA,typeB] (easily expandable).
### - Does not distinguish 5.x from 5.y, etc.
### though it doesn't really matter
### - typeA, typeB are hypothetical extra attributes

## Get 1. Distro name, 2. version, and 3. arch
## The input string format is:
## <distro>-<version>-<arch>.

require 'config'
require 'yaml'

## Takes a distro name and returns the OS family that
## it belongs to (i.e. EL, Deb(ian), SuSE)
def find_family(distro)
  el = ['CentOS','RedHat','SL','Oracle','EL']
  deb = ['Ubuntu','Debian','Deb']
  suse = ['SuSE','SuSE']
  os_family = [el, deb, suse]
  family = ''
  os_family.each do |type|
    if type.include?(distro)
      return type.last
    end
  end
end

## Parses the input into an array
def resolve(ostype)
  info = ostype.split('-')
  distro = info[0]
  version = info[1]
  arch = info[2]
  type = info[3]
  family = find_family(distro) 
  return distro, version, arch, type, family
end

## Lots of hardcoded things are in here. If there's any problem running
## the code, the cause is probably lurking down here.
## Function: look up hashes (yaml) and get options.
def get_value(ostype,instruction,opt)
  distro, version, arch, type, family = resolve(ostype)
  
  base_path = ''
  if instruction == 'definition'
    base_path = File.join(defn_dir,'seeds')
  elsif instruction == 'kickstart'
    base_path = File.join(ks_dir,'seeds')
  end

  ## Locations of yaml files
  file_locs = {
    ## for definition.rb
    'os_type_id' => base_path + '/os_type_id.yml',
    'iso_file' => base_path + '/iso_file.yml',
    'boot_cmd_sequence' => base_path + '/boot_cmd_sequence.yml',
    'kickstart_file' => base_path + '/kickstart_file.yml',
    'postinstall_files' => base_path + '/postinstall_files.yml',
    ## for ks.cfg
    'reponame' => base_path + '/reponame.yml',
    'pkgs' => base_path + '/pkgs.yml'
  }
  ## specify dependencies for each config option
  ## OS_TYPE_ID. depends on 'distro' 'version' 'arch'
  #  os_type_id.yml is pretty much the same as ostypes.yml
  #  but rewriting it to a nested hash serves this better.
  ## ISO name (must be in /veewee/iso/). depends on 'distro' 'version' 'arch'
  ## BOOT_CMD_SEQUENCE. depends on 'family' 'version'
  ## KICK_START_FILE. depends on same as above
  ## POSTINSTALL_FILES. depends on 'distro' 'version' 'type'
  #  (and probably a bit on 'arch' as well but not doing that right now)
  ## REPONAME
  ## PKGS
  dependencies = {
    'os_type_id' => [distro, version, arch],
    'iso_file' => [distro, version, arch],
    'boot_cmd_sequence' => [family,version],
    'kickstart_file' => [family,version],
    'postinstall_files' => [distro,version,type],
    'reponame' => [distro,version],
    'pkgs' => [distro,version,type]
  }
  
  deps = dependencies[opt]
  yamlfile = file_locs[opt]
  print "Loading #{yamlfile}... "
  source = YAML.load_file(yamlfile)
  puts "Done."
  # resolve each dependency IN ORDER
  deps.each do |dep|
    source = source[dep]
  end
  return source
end


def get_vars(instruction)
  if instruction == 'definition'
    erb_vars = ['os_type_id','iso_file','boot_cmd_sequence','kickstart_file','postinstall_files']
  elsif
    erb_vars = ['reponame','pkgs']
  end
  return erb_vars
end


def check_input(os)
  if  os.split('-').length != 4
    abort 'Incorrect input. Need <distro>-<version>-<arch>-<type>.'
  end
end

def get_os_seed(os,instruction,erb_vars)
  seed = {} # Type of a seed is hash.
  erb_vars.each do |var|
    print "Defining #{var}... "
    seed[var] = get_value(os,instruction,var)
    puts "#{var} defined."
  end
  return seed
end

## Input: os name (String), instruction (either kickstart or definition) (String)
## Output: hash, where keys are installation variables
def seed_builder(os,instruction)
  check_input(os)
  erb_vars = get_vars(instruction)
  distro, version, arch, type, family = resolve(os)
  seed = get_os_seed(os,instruction,erb_vars)
end

if __FILE__ == $0
  os = ARGV[0]
  instruction = ARGV[1] # -> definition or kickstart
  puts seed_builer(os,instruction).to_yaml
end

