#!/usr/bin/env ruby
### namegen.rb
### A neat script to produce a list of
### all combinations of distro-ver.-arch
### for EL family distros
eldistro = ['CentOS','RedHat','Oracle','SL']
elversion = ['5','6']
debdistro = ['Ubuntu','Debian']
debversion = ['10','12','6']
arch = ['32','64']
type = ['typeA','typeB'] # create full list
#type = ['typeA'] # only typeA for testing purpose

list = ['distro','version','arch','type']


def nested_hash(array_of_arrays)
  hash = {}
  arr = array_of_arrays
  tmp = arr.pop
  tmp.each do |val|
    hash[val] = ''
  end
  return helper(hash,arr)
end

def helper(hash,array)
  if array.empty?
    return hash
  end
  tmp = {}
  arr = array.pop
  arr.each do |val|
    tmp[val] = hash
  end
  return helper(tmp,array)
end

if __FILE__ == $0
  require 'yaml'
  if ARGV.length == 0
    abort 'no input!'
  end

  hash = {}
  if ARGV[0] == 'el'
  hash = {
    'distro' => eldistro,
    'version' => elversion,
    'arch' => arch,
    'type' => type
  }
  elsif ARGV[0] == 'deb'
  hash = {
    'distro' => debdistro,
    'version' => debversion,
    'arch' => arch,
    'type' => type
  }
  end

  contents = []
  list.each do |elm|
    if ARGV[1..-1].include?(elm)
      contents << hash[elm]
    end
  end

  result = nested_hash(contents)
  # the following line is weird but I had to hack it up
  # if 'puts result.to_yaml' were used, it returns a
  # yaml hash containing object reference
  puts eval(result.inspect).to_yaml
end
