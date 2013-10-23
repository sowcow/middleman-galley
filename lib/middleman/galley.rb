require 'middleman/galley/version'
require 'middleman/galley/gem_stuff'
require 'middleman/galley/resources'
require 'middleman' # kinda required...
require 'delegate'

module Middleman
  module Galley

    class Ext < Extension
      extend GemStuff

      self.option :at, 'gallery',
        'gallery directory'

      self.option :template, here('templates/page.html'),
        'template for missing pages'

      def initialize app, options_hash={}, &block
        super
      end

      def manipulate_resource_list resources
        res = Resources.new resources, options.template
        missing.each { |dir|
          res.prepare_page dir + 'index.html'
        }
        res.all
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
        }.map { |x| x.relative_path_from src }
      end
    end
  end

  Extensions.register :galley, Galley::Ext
end
