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

require 'origami_config'
require 'yaml'
require 'origami/core/name_parser'
require 'origami/core/build_helper'

module Origami
 
  ## get_value: look up hashes (yaml) and get options.
  def get_value(ostype,instruction,opt)
    distro, version, arch, type, family = resolve(ostype)
    deps = dependencies(opt)
    yamlfile = file_location(instruction,opt)
    print "Loading #{yamlfile}... "
    source = YAML.load_file(yamlfile)
    puts "Done."
    # resolve each dependency IN ORDER
    deps.each do |dep|
      source = source[dep]
    end
    return source
  end

  ## get_vars: look up what options must be specified
  ##           for a given template
  def get_vars(instruction)
    dictionary = {
      'definition' => ['os_type_id','iso_file','boot_cmd_sequence','postinstall_files'],
      'kickstart' => ['reponame','pkgs'],
      'preseed' => [],
      'autoyast' => []
    }
      # 'kickstart_file' option in definition.rb is deprecated
      # erb_vars = ['os_type_id','iso_file','boot_cmd_sequence','kickstart_file','postinstall_files']
    return erb_vars[instruction]
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
    return get_os_seed(os,instruction,erb_vars)
  end

  if __FILE__ == $0
    os = ARGV[0]
    instruction = ARGV[1] # -> definition or kickstart
    puts seed_builer(os,instruction).to_yaml
  end

end
