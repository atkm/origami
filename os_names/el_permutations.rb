
distro = ['CentOS','RedHat']
version = ['5','6']
arch = ['32','64']
type = ['typeA','typeB']

distro.each do |d|
  version.each do |v|
    arch.each do |a|
      type.each do |t|
        puts d + '-' + v + '-' + a + '-' + t
      end
    end
  end
end

if __FILE__ == $0
  require 'yaml'
  list = YAML.load_file('el_perms.yml')
  puts list.inspect
end
