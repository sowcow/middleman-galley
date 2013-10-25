# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/galley/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-galley"
  spec.version       = Middleman::Galley::VERSION
  spec.authors       = ["Alexander K"]
  spec.email         = ["xpyro@ya.ru"]
  spec.description   = %q{convenient and simplistic image gallery for middleman }
  spec.summary       = %q{image gallery for middleman}
  spec.homepage      = "https://github.com/sowcow/middleman-galley/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'nokogiri'
  #spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'chunky_png'
  # moved to Gemfile:
  #spec.add_development_dependency 'guard-cucumber', group: :guard
  spec.add_runtime_dependency 'middleman', '~> 3.1'
  spec.add_runtime_dependency 'fastimage'
end
