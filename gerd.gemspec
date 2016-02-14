# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gerd/version'

Gem::Specification.new do |spec|
  spec.name          = "gerd"
  spec.version       = Gerd::VERSION
  spec.authors       = ["George McIntosh"]
  spec.email         = ["george@elevenware.com"]
  spec.description   = %q{Githur hErd: manage GitHub repositories declaratively}
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
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

  spec.add_dependency "thor"
  spec.add_dependency "require_all"
end
