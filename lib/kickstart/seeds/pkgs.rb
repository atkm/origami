require 'yaml'

hash = {
  'CentOS' => {
    '5' => {
      'typeA' => ['@core','ruby','openssh','openssh-clients','openssh-server'],
      'typeB' => ['@core','ruby','openssh','openssh-clients','openssh-server','elinks']
    },
     '6' => {
      'typeA' => ['@core','ruby','openssh','openssh-clients','openssh-server'],
      'typeB' => ['@core','ruby','openssh','openssh-clients','openssh-server','elinks']
    }
 },
  'RedHat' => {
    '6' => {
      'typeA' => ['@core','ruby','openssh','openssh-clients','openssh-server'],
      'typeB' => ['@core','ruby','openssh','openssh-clients','openssh-server','elinks']
    } 
  }
}

if __FILE__ == $0
  puts hash.to_yaml
end
