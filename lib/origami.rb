#!/usr/bin/env ruby
### origami.rb
### Calls build_from_seed.rb
### Usage: origami.rb <name> [<target directory>] [<instruction=--kickstart,--definition>]
### OR!
###        origami.rb --file <file.yml> [<target directory>] :: where <file.yml> contains an array of names

require 'build_from_seed'
require 'optparsing'

module Origami
  extend self

  def project_root
    File.expand_path(
                     File.join(File.dirname(__FILE__), '..')
                     )
  end
  
  def craft(options)
    
    names = options[:name]
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
    end#block
    
  end#def
end#Module
