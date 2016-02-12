# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grim/version'

Gem::Specification.new do |spec|
  spec.name          = "grim"
  spec.version       = Grim::VERSION
  spec.authors       = ["George McIntosh"]
  spec.email         = ["george@elevenware.com"]
  spec.description   = %q{Manage GitHub repositories declaratively}
  spec.summary       = %q{Manage your GitHub estate declaratively}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_dependency "thor"
end
