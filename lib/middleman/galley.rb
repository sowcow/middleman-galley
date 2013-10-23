require 'middleman/galley/version'
require 'middleman/galley/gem_stuff'
require 'middleman/galley/helper'
require 'middleman' # kinda required...
require 'fileutils'


module Middleman
  module Galley

    class Ext < Extension
      extend GemStuff

      self.option :at, 'gallery',
        'gallery directory'

      # todo: templates/index.*?'
      self.option :lang, 'erb',
        'erb / slim / any?'

      template = here('templates/index.erb')

      self.option :template, template,
        'template for missing pages'

      def initialize app, options_hash={}, &block
        super

        missing.each { |dir|
          base = Pathname(options.template).basename.to_s
          dest = dir + base
          FileUtils.cp options.template, dest.to_s
        }
      end

      helpers do
        def galley
          ::Middleman::Galley::Helper.new self
        end
      end

      private
      def missing
        src = Pathname('source')
        dir = src + options.at
        dirs = [dir] + Pathname.glob(dir + '**/**')
                               .select(&:directory?)
        missing = dirs.reject { |x|
          x.children.any? { |x|
            x.to_s =~ /\/index(\.[^\/]+)?$/ }
        }
      end
    end
  end

  Extensions.register :galley, Galley::Ext
end
