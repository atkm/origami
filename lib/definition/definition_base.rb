#!/usr/bin/env ruby
### Author: Atsuya Kumano
### Date: July 2012
### Test of directory heirarchy establishment

### copied and modified ks_base.rb for definition purpose
### must rename the class and think about class inheritance
### (or class inheritance is needed at all)
### Also see erb_builder.rb, which takes inputs (seed) and creates a complete config file.

require 'erb_base'

module Origami
  class DefinitionBase < Base
    attr_accessor :os_type_id, :iso_file, :boot_cmd_sequence, :kickstart_file, :postinstall_files

    ## my default settings
    def initialize
      @os_type_id = nil
      @iso_file = nil
      @boot_cmd_sequence = nil
      @kickstart_file = nil
      @postinstall_files = nil
    end
    
  end #Class

  if __FILE__ == $0
    s = Base.new
    #puts s.install_option
    #puts s.instance_variables
    #s.install_option = 'net'
    # puts s.install_option
    puts s.list_defined
    puts
    puts s.list_undefined
  end
end
