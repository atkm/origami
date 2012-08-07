### add_new_type.rb
### A utility to create new seed files from a user input.
### Two modes: interactive & file processing.

require 'create_type'

def add_new_type_interactive
  puts "Initiating an interactive process to create a new type. (press ENTER)"
  gets
  puts "Enter distro. Choose from"
  puts "CentOS SL Oracle RedHat Debian Ubuntu SLES:"
  distro = gets.strip
  puts "Enter version:"
  puts "(EL: 5 or 6. Ubuntu: 10 or 12. Debian: 6. SLES: 11.)"
  version = gets.strip
  puts "Enter arch (32 or 64)"
  arch = gets.strip
  puts "Enter a unique identifier:"
  type = gets.strip
  name = [distro, version, arch, type] * '-'
  puts "New template #{name} will be created. (hit ENTER to continue)"
  gets
  # iso_file
  puts "Enter the name of iso (it must be in seisan-line/veewee/iso):"
  iso_file = gets
  # postinstall_files
  puts "Enter post-install scripts to be executed"
  puts "(The scripts should be in seisan-line/postscripts.)"
  postinstall_files = parse_to_array(gets)
  # pkgs
  puts "Enter the packages to be installed (comma separated"
  puts "e.g. git, ruby,zsh):"
  pkgs = parse_to_array(gets)
  puts "The end. Summary:"
  puts "Name: #{name}"
  puts "ISO: #{iso_file}"
  puts "Post-install scripts:"
  puts postinstall_files.inspect
  puts "Packages:"
  puts pkgs.inspect
  puts "Create this type? [Y/n]"
  ans = gets
  if ans == 'Y' or ans == 'y'
    type_attributes = {:name => name, :iso_file => iso_file, :postinstall_files => postinstall_files, :pkgs => pkgs}
    create_type(type_attributes)
  end
  
end

def parse_to_array(str)
  return str.split(',').collect do |part|
    part.strip
  end
end

if __FILE__==$0
  add_new_type_interactive
end
