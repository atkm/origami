Veewee::Definition.declare({
  :cpu_count => '1',
  # original: '400'
  :memory_size=> '512',
  :disk_size => '10140',
  # original: 'VDI'. Since VMware box is created, vmdk is obviously needed.
  :disk_format => 'VMDK',
  # disk type also configurable in /lib/veewee/provider/vmfusion/box/create.rb
  # the default is "single growable virtual disk"
  :hostiocache => 'off',
  # I/O APIC: related to performace/security
  :ioapic => 'on',
  :pae => 'on',
  # OS type used in initializing a vm.
  # allowed inputs are found in ostypes.yml under ~/lib/veewee/config/
  :os_type_id => 'Centos_64',
  :iso_file => "CentOS-6.2-x86_64-bin-DVD1.iso",
  # iso_src: fetches iso if it's not available
  :iso_src => "http://be.mirror.eurid.eu/centos/6.2/isos/x86_64/CentOS-6.2-x86_64-netinstall.iso",
  :iso_md5 => "7e7f4161a5c8c49032655e5f4ecd1f07",
  :iso_download_timeout => 1000,
  :boot_wait => "3",
  :boot_cmd_sequence => [ '<Tab> text ks=http://192.168.100.225/~atsuya/ks_test.cfg <Enter>' ],
  # (probably) %IP% given by ":kickstart_ip" and %PORT% given by ":kickstart_port"
  # <Tab> => "edit boot argument"; text => avoid starting X at boot; ks=* => EL's boot option to use kickstart
  # original:
  # :boot_cmd_sequence => [ '<Tab> text ks=%IP$:%PORT%/ks.cfg <Enter>' ],
  # :kickstart_ip has be specified, though absent in the original. (used in build.rb)
  :kickstart_port => "7122",
  :kickstart_timeout => 10000,
  # read by /core/box/build.rb
  :kickstart_file => "custom-ks.cfg",
  :ssh_login_timeout => "10000",
  # After installation, it tries to ssh into itself using the following identity
  :ssh_user => "root",
  :ssh_password => "puppet",
  :ssh_key => "",
  :ssh_host_port => "7222",
  :ssh_guest_port => "22",
  :sudo_cmd => "echo '%p'|sudo -S sh '%f'",
  :shutdown_cmd => "/sbin/halt -h -p",
  :postinstall_files => [
    # commenting these out as the current ks.cfg requires these packages to be installed.	
    # "base.sh",
    # "ruby.sh",
    # "chef.sh",
    # "puppet.sh",
    # "vagrant.sh",
    # "virtualbox.sh",
    # "kvm.sh",
    # "vmfusion.sh",
    # "cleanup.sh"
    "hello.sh"
  ],
  :postinstall_timeout => 10000
})
