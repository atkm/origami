#!/usr/bin/env ruby
### mseed.rb
### Reads a seed with empty entries.
### Recursively follow hash, replace it with a disired
### entry when an empty entry is found.

require 'yaml'


def follow_hash(hash,input)
  hash.each_pair do |key,val|
    if val == ''
      hash[key] = input
    else
      hash[key] = follow_hash(val,input)
    end
  end
  return hash
end
  
if __FILE__ == $0
  hash = YAML.load_file(ARGV[0])
  if ARGV.length > 1
    input = ARGV[1..-1]
  else
    input = ARGV[1]
  end
  puts eval(follow_hash(hash,input).inspect).to_yaml
end
