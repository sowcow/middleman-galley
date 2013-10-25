require 'forwardable'
require 'fastimage'

module Middleman::Galley

    class Template
      @@known = {}
      def self.[] name
        name = name.to_sym
        @@known[name]
      end

      def self.register name
        name = name.to_sym
        @@known[name] = self
      end

      def self.build context
        new(context).build
      end

      def initialize context
        @context = context
      end

      private
      delegate :content_tag, to: :a

      def a # rid?
        @context
      end

      def children
        @context.current_page.children
      end

      def image_tags
        children.sort_by(&:url).map { |x| image x }.compact
      end

      def image res
        return nil unless image? res
        url = if a.relative_links
                relative res.url
              else
                res.url
              end
        w, h = FastImage.size res.source_file
        a.tag :img, src: url, width: w, height: h
      end

      IMG = /\.(png|jpg|jpeg|gif|svg|bmp)$/
      def image? res
        res.source_file =~ IMG
      end

      def relative url
        url.sub a.current_page.url, ''
      end
    end
end
