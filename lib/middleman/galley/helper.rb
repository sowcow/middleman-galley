require 'middleman/galley/gallery_template'

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
         .sort_by { |x| name x }
         .map { |x| link x }
         .join
      end

      # to extract as a partial?...
      def images gallery_template = :default
        if gallery_template == :default
          gallery_template = a.galley!
                              .options.default_template
        end
        GalleryTemplate[gallery_template].build a
      end

      private
      IMG = /\.(png|jpg|jpeg|gif|svg|bmp)$/

      def image? res
        res.source_file =~ IMG
      end
      def nested? res
        res.path =~ /\/index\.html$/
      end

      def name res
        Pathname(res.url).basename.to_s
      end

      def link res
        a.link_to name(res), res
      end
    end
  end
end
