### Takes a string of the form <distro>-<version>-<arch>-<type> then
### 1. Create a directory inside the hierarchy structure of
### '~/veewee/definitions/**'
### 2. Make kickstart seed (seed_builder.rb kickstart)
### 3. Build kickstart.cfg (ks_builder.rb <ks_seed>)
### 4. Place it in the directory as well as on a http server
### 5. Make definition seed (seed_builder.rb definition)
### 6. Build definition.rb (definition_builder.rb <defn_seed>)
### 7. (same as 4.)
### 8. Launch VM creation (vwf <definition_name>)

require 'config'
require 'erb_base'
require 'seed_builder'
require 'ks_defn_builder'
require 'kickstart/ks_base'
require 'definition/definition_base'

def create_dir(name)
  puts "Creating directory for #{name}..."
  puts "~/veewee/definition/distro/version/arch/type"
end

def build_from_seed(name,instruction)
  ks_erb = File.join(ks_dir, 'ks_base.erb')
  defn_erb = File.join(defn_dir, 'definition_base.erb')
  
  erb_path = {'kickstart' => ks_erb, 'definition' => defn_erb}[instruction]
  filename = {'kickstart' => 'ks.cfg', 'definition' => 'definition.rb'}[instruction]
  
  seed = seed_builder(name,instruction)
  File.open(Dir.pwd + '/products/' + name + '_' + filename,'w') do |file|
    print "Creating #{name}_#{filename}... "
    file.write(ks_defn_builder(instruction,erb_path, seed))
  end 
  puts "Done."
end

if __FILE__ == $0
  ARGV.each do |name|
    build_from_seed(name,'kickstart')
    build_from_seed(name,'definition')
  end
end
