### using system([env,] command [,options] to use seed_builder.rb
require 'yaml'
list = YAML.load_file('/Users/atsuya/Code/ERB/alpha/el_perms.yml')
list.each do |type|
  puts "Creating seed for #{type} !!!"
  system('ruby', 'seed_builder.rb', type)
end
