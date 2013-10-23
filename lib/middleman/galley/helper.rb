#require 'delegate' #< SimpleDelegator

module Middleman
  module Galley
    class Helper
      def initialize context
        @a = context
      end
      attr_reader :a

      def nested
        a.current_page.children.select { |x| nested? x }
         .map { |x| link x }
         .join
      end

      private
      IMG = /\.(png|jpg|jpeg|gif|svg|bmp)&/

      def image? res
        res.source_file =~ IMG
      end
      def nested? res
        res.path =~ /\/index\.html$/
      end

      def link res
        name = Pathname(res.url).basename.to_s
        a.link_to name, relative(res.url)
      end

      # middleman dont want to do that...
      def relative url
        url.sub a.current_page.url, ''
      end
    end
  end
end
