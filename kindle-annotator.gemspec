# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kindle/annotator/version'

Gem::Specification.new do |spec|
  spec.name          = "kindle-annotator"
  spec.version       = Kindle::Annotator::VERSION
  spec.authors       = ["Nate Klaiber"]
  spec.email         = ["nate@theklaibers.com"]
  spec.summary       = %q{ Extract your Kindle Highlights and Notes. }
  spec.description   = %q{ A utility that allows you to extract your Kindle Highlights, Notes, Books, and Authors. }
  spec.homepage      = "https://github.com/nateklaiber/kindle-annotator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency("bundler", "~> 1.7")
  spec.add_development_dependency("rake", "~> 10.0")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("yard")

  spec.add_dependency("multi_json")
  spec.add_dependency("terminal-table")
  spec.add_dependency("mechanize")
  spec.add_dependency("dotenv")
  spec.add_dependency("addressable")
  spec.add_dependency("thor")
  spec.add_dependency("ruby-progressbar")
end
