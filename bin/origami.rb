#!/usr/bin/env ruby
### origami.rb
### Calls build_from_seed.rb
### Usage: origami.rb <name> [<target directory>] [<instruction=--kickstart,--definition>]
### OR!
###        origami.rb --file <file.yml> [<target directory>] :: where <file.yml> contains an array of names

project_path = File.expand_path(
                    File.join(File.dirname(__FILE__), '..', 'lib'))
# puts project_path
$LOAD_PATH.unshift(project_path) unless $LOAD_PATH.include?(project_path)

require 'build_from_seed'
require 'optparse'

if ARGV.length == 0
  piece_of_art = File.new(File.join(File.dirname(__FILE__), 'hello.txt'),'r').read
  print( piece_of_art + "\n")
  print("'origami --help' for usage\n\n")
else
  names = [ARGV[0]]
  
  options = {}
  optparse = OptionParser.new do |opts|
    opts.banner = "Usage: origami.rb name [options]"
    
    options[:target] = nil
    opts.on('--target DIR') do |dir|
      options[:target] = dir
    end
    
    options[:instruction] = nil
    opts.on('--definition') do
      options[:instruction] = 'definition'
    end
    opts.on('--kickstart') do
      options[:instruction] = 'kickstart'
    end

    options[:file] = nil
    opts.on('--file FILE') do |file|
      options[:file] = file
    end
    
    opts.on('-h','--help') do
      puts opts
      exit
    end
    
  end
  
  optparse.parse!

  target = options[:target]

  if options[:file] != nil
    require 'yaml'
    names = YAML.load_file(options[:file])
  end
  
  names.each do |name|
    if options[:instruction] == nil
      build_from_seed(name,'kickstart', target)
      puts
      build_from_seed(name,'definition', target)
      puts
    else
      build_from_seed(name, options[:instruction], target)
      puts
    end
  end
end
