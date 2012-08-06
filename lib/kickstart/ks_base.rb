#!/usr/bin/env ruby
### Author: Atsuya Kumano
### Date: July 2012
### Successor of ks_base.rb
### Test of directory heirarchy establishment

### 
### Also see ks_builder.rb, which takes inputs (seed) and creates a complete config file.

#require 'erb_base' 

module Origami
  class KsBase < Base
    attr_accessor :install_option, :lang, :keyboard, :network, :rootpw, :firewall, :authconfig, :selinux, :timezone, :bootloader, :skipx, :partition, :power_option, :reponame, :baseurl, :pkgs

    def initialize
      @reponame = nil
      @pkgs = nil
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
