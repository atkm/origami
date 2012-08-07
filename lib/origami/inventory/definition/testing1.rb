### Test for pkgs. Does <%= pkgs.inspect %> do the job for erb?
require 'erb'

erb = File.new('definition_base.erb','r').read
tmpl = ERB.new(erb)
os_type_id = 'CentOS_64'
iso_file = 'centos_dvd1.iso'
boot_cmd_sequence = '<Tab> <Enter>'
kickstart_file = 'ks6.cfg'
pkgs = ['openssh','openssh-client','openssh-server','git','ruby','rdoc']

puts tmpl.result(binding)
