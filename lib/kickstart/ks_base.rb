#!/usr/bin/env ruby
### Author: Atsuya Kumano
### Date: July 2012
### Successor of ks_base.rb
### Test of directory heirarchy establishment

### 
### Also see ks_builder.rb, which takes inputs (seed) and creates a complete config file.

require 'erb_base' 

module Origami
  class KsBase < Base
    attr_accessor :install_option, :lang, :keyboard, :network, :rootpw, :firewall, :authconfig, :selinux, :timezone, :bootloader, :skipx, :partition, :power_option, :reponame, :baseurl, :pkgs

    ## my default settings
    def initialize
      @install_option = 'cdrom'
      @lang = 'en_US.UTF-8'
      @keyboard = 'us'
      @network = '--onboot=yes --device=eth0 --bootproto=dhcp'
      @rootpw = '--iscrypted $6$3spQCA5HQwFZB5y7$FvrXdUDF7CNofJ8DIIVQYB.MyBBxYRXOU9GMbdfKRiFFjUVo/ZrKkkNvMgKQ2sRoGtDt7M3lFLOPp0FiqLBp.0'
      @firewall = '--enabled --trust eth0 --ssh'
      @authconfig = '--enableshadow --enablemd5'
      @selinux = '--disabled'
      @timezone = 'America/Los_Angeles'
      @bootloader = "--location=mbr --driveorder=sda --append=' rhgb crashkernel=auto quiet'"
      @skipx = 'skipx'
      @partition = 'autopart'
      @power_option = 'reboot'
      @reponame = nil
      @baseurl = 'file:///mnt/source'
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
