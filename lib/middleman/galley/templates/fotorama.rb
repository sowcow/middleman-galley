module Middleman::Galley

    class Fotorama < Template
      register :fotorama

      def build
        content_tag(:script, src:
                      "http://code.jquery.com/jquery-1.10.2.min.js"){''}
        content_tag(:script, src:
                      "http://fotorama.s3.amazonaws.com/4.4.6/fotorama.js"){''}
        content_tag(:script) do <<tag
$("head").append("<link rel='stylesheet' href='http://fotorama.s3.amazonaws.com/4.4.6/fotorama.css' />");
tag
        end

        content_tag(:div, class: 'fotorama') do
          image_tags.join
        end

        nil
      end
    end
end
