#!/usr/bin/env ruby
### Author: Atsuya Kumano
### Date: July 2012
### Test of directory heirarchy establishment

### ks_base.rb -> definition_base.rb -> erb_base.rb
### (It was quite dumb to initialize class instance
### variables in Base class.)
###
### Methods necessary to build a config file
### from erb and seeds are defined in this class.
### Use KsBase < Base, DefinitionBase < Base
### (ks_base.rb, definition_base.rb)

module Origami
  class Base

    ## A setter for installation parameters. usage:
    ## s = Seed.new
    ## s.lang = 'ja_JP.eucjp'  # => changes 'lang' to Japanese
    def opt=(val)
      @opt = val
    end

    ## lists defined variables
    def list_defined
      tmp = instance_variables.collect do |var|
        unless instance_variable_get(var) == nil
          var
        end
      end
      tmp.compact
    end

    ## lists undefined variables (nil-valued ones)
    def list_undefined
      instance_variables - list_defined
    end

    ## load a template (*.erb content)
    def load_erb(erb)
      # @tmpl = ERB.new(erb)
      @tmpl = ERB.new(erb,0,"<>")
    end

    def get_binding
      binding
    end

    ## define variables from a hash
    def slurp(hash)
      hash.each_key do |opt|
        val = hash[opt]
        instance_variable_set(eval(':@' + opt),val)
      end
    end

    def showoff
      if list_undefined.length == 0
        return @tmpl.result(self.get_binding)
      else
        puts 'The following parameters are unspecified:'
        puts list_undefined
      end
    end
    
  end #Class
end#Module
