#!/usr/bin/env ruby
### Takes a string of the form <distro>-<version>-<arch>-<type> then
### 1. Create a directory inside the hierarchy structure of
### '~/veewee/definitions/**'
### 2. (assume instruction='kickstart') Make kickstart seed (seed_builder.rb kickstart)
### 3. Build kickstart.cfg (ks_builder.rb <ks_seed>)

### To use it: (== follow veewee instruction)
### Place definition.rb in the directory && place ks.cfg on a http server
### Launch VM creation (vwf <definition_name>)

### Usage: build_from_seed.rb <os_name> <instruction> <target>
### os_name = <distro>-<version>-<arch>-<type>
### instruction = kickstart or definition
### target = target directory to place the files in

require 'origami_config'
require 'origami/core/erb_base'
require 'origami/core/seed_builder'
require 'origami/core/ks_defn_builder'
require 'origami/inventory/kickstart/ks_base'
require 'origami/inventory/definition/definition_base'
require 'origami/inventory/preseed/preseed_base'
require 'origami/inventory/autoyast/autoyast_base'

module Origami

  ## Originally I meant to manage directories from here.
  ## It will be managed by puppet now.
  def create_dir(name)
    puts "Creating directory for #{name}..."
    puts "~/veewee/definition/distro/version/arch/type"
  end

  ## The main fucntion.
  ## Uses ks_base.erb and definition_base.erb as template.
  ## ks_defn_builder creates ks.cfg and definition.rb. (see ks_defn_builder.rb)
  ## seed_builder provides a hash that specifies options.
  def build_from_seed(name,instruction,target=nil)
    ks_erb = File.join(ks_dir, 'ks_base.erb')
    defn_erb = File.join(defn_dir, 'definition_base.erb')
    autoyast_erb = File.join(autoyast_dir, 'autoyast_base.erb')
    preseed_erb = File.join(preseed_dir, 'preseed_base.erb')
    erb_path = {'kickstart' => ks_erb, 'definition' => defn_erb, 'autoyast' => autoyast_erb, 'preseed' => preseed_erb}[instruction]
    filename = {'kickstart' => 'ks.cfg', 'definition' => 'definition.rb', 'autoyast' => 'autoinst.xml', 'preseed' => 'preseed.cfg'}[instruction]

    seed = seed_builder(name,instruction)
    if target == nil
      target = project_root + '/products/'
    end


    File.open( File.join( target , name + '_' + filename), 'w') do |file|
      print "Creating #{name}_#{filename}... "
      content = ks_defn_builder(instruction,erb_path, seed)
      file.write(content)
    end
    puts "Done."
    print("#{instruction} file was created in #{target}.\n\n")
  end

  if __FILE__ == $0
    name = ARGV[0]
    instruction = ARGV[1]
    if ARGV.length == 3
      target = ARGV[2]
    else
      target = nil
    end
    build_from_seed(name,'kickstart', target)
    build_from_seed(name,'definition', target)
  end
end
