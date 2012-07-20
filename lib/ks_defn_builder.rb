#!/usr/bin/env ruby
### ks_defn_builder.rb
### Input: instruction (kickstart or definition),
###        erb (template), and seeds
### Seeds are yaml files containing hashes
### specifying installation options: see definition_alpha/os_seeds/
### Output: a complete configuration file.
###
### Usage:
### ./ks_builder.rb <instruction> <erb> <seed>
### e.g. ./ks_builder.rb kickstart ks_base.erb CentOS-5-32-typeA.seed.yml

require 'erb'
require 'yaml'
require_relative 'kickstart/ks_base'
require_relative 'definition/definition_base'

def ks_defn_builder(instruction,erb,seed)
  tmpl = nil
  if instruction == 'kickstart'
    tmpl = KsBase.new
  elsif instruction == 'definition'
    tmpl = DefinitionBase.new
  end 
  tmpl.load_erb(File.open(erb).read)

  ## Alternative Version: more than one seeds can be fed
  ## advantage: the user can feed h[is,er] own seed
  ##            and override the ones that exist in
  ##            seeds/ directory.
  ## seeds.each do |yamlfile|
  ##  hash = YAML.load_file(yamlfile)
  ##  kscfg.slurp(hash)
  ## end

  tmpl.slurp(seed)
  return tmpl.showoff
end

if __FILE__ == $0
  instruction = ARGV[0]
  erb = ARGV[1]
  seed = YAML.load_file(ARGV[2])
  puts ks_defn_builder(instruction,erb,seed)
end
