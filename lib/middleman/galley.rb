require 'middleman/galley/version'
require 'middleman/galley/gem_stuff'
require 'middleman/galley/helper'
require 'middleman' # kinda required...
require 'fileutils'


module Middleman
  module Galley

    module Method
      def galley!
        extensions[:galley].values.find { |x|
          x.has? current_page
        }
      end
    end

    class Ext < Extension
      extend GemStuff

      self.option :default_template, 'fotorama',
        'default gallery template'

      self.option :at, 'gallery',
        'gallery directory'

      # todo: templates/index.*?'
      self.option :lang, 'erb',
        'erb / slim / any?'

      template = here('templates/index.erb')

      self.option :template, template,
        'template for missing pages'

      def self.supports_multiple_instances?
        true
      end

      def initialize app, options_hash={}, &block
        app.send :include, Galley::Method

        super

        missing.each { |dir|
          base = Pathname(options.template).basename.to_s
          dest = dir + base
          FileUtils.cp options.template, dest.to_s
        }
      end

      def has? page
        at = options.at
        at = at[0] == ?/ ? at : "/#{at}"
        page.url.index(at) == 0
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
