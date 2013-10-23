require 'middleman/galley/version'
require 'middleman/galley/gem_stuff'
require 'middleman' # required...
require 'delegate'

module Middleman
  module Galley

    class Ext < Extension
      extend GemStuff

      self.option :at, 'gallery',
        'gallery directory'

      self.option :template, here 'templates/page.html',
        'template for missing pages'

      def initialize app, options_hash={}, &block
        super
      end

      def manipulate_resource_list resources
        res = Resources.new resources, options.template
        res.prepare_page 'gallery/index.html'
        res.all
      end
    end

    class Resources < SimpleDelegator
      alias all __getobj__
      attr_reader :template

      def initialize obj, template
        @template = template
        super obj
      end

      def prepare_page path
        res = new_res path
        all << res
      end

      def store
        @store ||= all.first.store
      end

      def new_res path
        Middleman::Sitemap::Resource.new \
          store, path, template
      end
    end

  end

  Extensions.register :galley, Galley::Ext
end

