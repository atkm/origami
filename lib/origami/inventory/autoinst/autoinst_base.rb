### preseed_base.rb

module Origami
  class AutoinstBase < Base
    attr_accessor :pkgs, :suite
    def initialize
      @pkgs = nil
    end
  end #Class
end
