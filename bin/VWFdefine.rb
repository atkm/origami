#!/usr/bin/env ruby
project_path = File.expand_path(
                    File.join(File.dirname(__FILE__), '..', 'lib'))
# puts project_path
$LOAD_PATH.unshift(project_path) unless $LOAD_PATH.include?(project_path)

require 'build_from_seed'

if ARGV.length == 0
  piece_of_art = File.new(File.join(File.dirname(__FILE__), 'hello.txt'),'r').read
  print( piece_of_art + "\n")
  print("Usage: VWFdefine osname\n\n")
else
  Dir.chdir(File.expand_path("~/Code/VWF_templating_engine"))
  ARGV.each do |name|
    build_from_seed(name,'kickstart')
    puts
    build_from_seed(name,'definition')
  end
end
