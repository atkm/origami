#!/usr/bin/env ruby
### origami.rb
### Calls build_from_seed.rb
### Usage: origami.rb <name> [<target directory>] [<instruction=--kickstart,--definition>]
### OR!
###        origami.rb --file <file.yml> [<target directory>] :: where <file.yml> contains an array of names

require 'origami/core/build'
require 'optparsing'

module Origami
  extend self
  
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
      instruction = OSName.new(name).instruction
      if options[:instruction] == nil
        build(name, instruction, target)
        puts
        build(name,'definition', target)
        puts
      else
        build(name, options[:instruction], target)
        puts
      end
    end
  end
    
end#Module
