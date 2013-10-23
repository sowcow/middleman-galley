#require 'delegate' #< SimpleDelegator

module Middleman
  module Galley
    class Helper
      def initialize context
        @a = context
      end
      attr_reader :a

      # to extract as a partial?...
      def nested
        a.current_page.children.select { |x| nested? x }
         .map { |x| link x }
         .join
      end

      # to extract as a partial?...
      def images
        a.current_page.children.select { |x| image? x }
         .sort_by { |x| x.url }
         .map { |x| image x }
         .join
      end

      private
      IMG = /\.(png|jpg|jpeg|gif|svg|bmp)$/

      def image? res
        res.source_file =~ IMG
      end
      def nested? res
        res.path =~ /\/index\.html$/
      end

      def link res
        name = Pathname(res.url).basename.to_s
        a.link_to name, res
      end

      def image res
        #return nil unless image? res #+optional compact ?
        url = if a.relative_links
                relative res.url
              else
                res.url
              end
        a.tag :img, src: url
      end

      def relative url
        url.sub a.current_page.url, ''
      end
    end
  end
end
