### preseed_base.rb

module Origami
  class PreseedBase < Base
    attr_accessor :pkgs, :suite
    def initialize
      @pkgs = nil
      @suite = nil
    end
  end #Class
end
