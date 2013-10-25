require_relative 'template'
require 'pathname'
here = Pathname(__FILE__).parent
Pathname.glob(here + 'templates/*.rb').each { |file|
  require_relative file.to_s
}
