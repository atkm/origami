### add_new_type.rb
### A utility to create new seed files from a user input.
### Two modes: interactive & file processing.

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
  puts "New template #{distro}-#{version}-#{arch}-#{type} will be created. (hit ENTER to continue)"
  gets
  # iso_file
  puts "Enter the name of iso (it must be in seisan-line/veewee/iso):"
  iso_file = gets
  # postinstall_files
  puts "Enter the names of post-install scripts to be executed"
  puts "(The scripts should be in seisan-line/postscripts.)"
  postinstall_files = gets
  # pkgs
  puts "There are a few options left to be filled out:"
  puts "reponame boot_cmd_sequence os_type_id"
end

if __FILE__==$0
  add_new_type_interactive
end
