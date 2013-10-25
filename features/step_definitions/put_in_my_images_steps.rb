require 'chunky_png'
require 'pathname'

def random_image
  w, h = 2.times.map { rand 100..200 }
  color = ChunkyPNG::Color.rgb *3.times.map { rand 0..255 }
  ChunkyPNG::Image.new w, h, color
end

And 'I put in my images:' do |table|
  files = table.raw.map &:first
  files.each { |file|
    in_current_dir {
      dir = Pathname(file).parent
      dir.mkpath unless dir.exist?
      random_image.save file, :fast_rgba
    }
    #file = file[0]
    #step "an empty file named \"#{file}\""
  }
end
