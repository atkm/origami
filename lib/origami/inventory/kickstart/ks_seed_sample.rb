require 'yaml'
hash = {
  'partition' => 'autopart',
  'power_option' => 'reboot',
  'reponame' => 'CentOS',
  'baseurl' => 'file:///mnt/source',
  'pkgs' => ['ruby','rdoc','git','openssh','openssh-client','openssh-server']
}

if __FILE__==$0
  puts hash.to_yaml
end
