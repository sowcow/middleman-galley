require "middleman/galley/version"

module Middleman

  class Galley::Galley < Extension
    def initialize app, options_hash={}, &block
      super
    end
  end

  Extensions.register :galley, Galley::Galley
end
