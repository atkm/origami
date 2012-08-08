#!/usr/bin/env ruby
### origami.rb
### Calls build_from_seed.rb
### Usage: origami.rb <name> [<target directory>] [<instruction=--kickstart,--definition>]
### OR!
###        origami.rb --file <file.yml> [<target directory>] :: where <file.yml> contains an array of names

require 'origami/core/build_from_seed'
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
    
    if options[:file] != nil
      require 'yaml'
      names = YAML.load_file(options[:file])
    end
    build_each(names,options)
  end

  def build_each(names,options)
    target = options[:target]
    names.each do |name|
      instruction = choose_instruction(name)
      if options[:instruction] == nil
        build_from_seed(name, instruction, target)
        puts
        build_from_seed(name,'definition', target)
        puts
      else
        build_from_seed(name, options[:instruction], target)
        puts
      end
    end
  end
    
end#Module
