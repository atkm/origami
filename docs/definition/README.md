## definition_alpha/ -- Directory contents ##

- definition_base.erb : `definition.rb` with variable replaced with erb codes.
  
- definition_base.rb : class DefinitionBase is defined. Note that it
    requires `erb_base.rb` from `~/alpha`.

- definition_builder.rb : `ruby definition_builder.rb <erb> <seed>*`  
    builds a complete template. Of course,
    you need to supply enough seeds.
  
- seeds/ : This is where all yaml files for building
  seeds are. Seeds are ugly redundant hashes in yaml.
  I bet using pattern matching will be a huge improvement.
  
  - seed_builder.rb : Takes a name of box and create a seed. Note: this was moved to `~/bin`.
  
- os_seeds/ : Put completed seed here.

