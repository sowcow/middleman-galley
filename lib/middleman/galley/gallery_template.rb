module Middleman
  module Galley
    class GalleryTemplate
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
      def a
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
        a.tag :img, src: url
      end

      IMG = /\.(png|jpg|jpeg|gif|svg|bmp)$/
      def image? res
        res.source_file =~ IMG
      end

      def relative url
        url.sub a.current_page.url, ''
      end
    end

    # todo extract:

    class Fotorama < GalleryTemplate
      register :fotorama

      def build
        a.content_tag(:script, src:
                      "http://code.jquery.com/jquery-1.10.2.min.js"){''}
        a.content_tag(:script, src:
                      "http://fotorama.s3.amazonaws.com/4.4.6/fotorama.js"){''}
        style = a.content_tag(:script) do <<tag
$("head").append("<link rel='stylesheet' href='http://fotorama.s3.amazonaws.com/4.4.6/fotorama.css' />");
tag
        end
        images = a.content_tag(:div, class: 'fotorama') do
          image_tags.join
        end

        nil
      end
    end
  end
end
