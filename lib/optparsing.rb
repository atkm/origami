### optparsing.rb

require 'optparse'

module Origami
  class Options
    attr_reader :options

    def self.parse_args
      @options = {}
      optparse = OptionParser.new do |opts|
        opts.banner = "Usage: origami.rb name [options]"
        
        @options[:target] = nil
        opts.on('--target DIR') do |dir|
          @options[:target] = dir
        end
        
        @options[:instruction] = nil
        opts.on('--definition') do
          @options[:instruction] = 'definition'
        end
        opts.on('--kickstart') do
          @options[:instruction] = 'kickstart'
        end
        
        @options[:file] = nil
        opts.on('--file FILE') do |file|
          @options[:file] = file
        end
        
        opts.on('-h','--help') do
          puts opts
          exit
        end
        
      end
      
      optparse.parse!
      
      return @options
    end
  end
end
