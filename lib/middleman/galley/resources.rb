require 'middleman'
require 'delegate'

module Middleman
  module Galley
    class Resources < SimpleDelegator
      alias all __getobj__
      attr_reader :template

      def initialize obj, template
        @template = template
        super obj
      end

      def prepare_page path
        res = new_res path.to_s
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
end
