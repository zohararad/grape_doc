# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape_doc/version'

Gem::Specification.new do |gem|
  gem.name          = "grape_doc"
  gem.version       = GrapeDoc::VERSION
  gem.authors       = ["Zohar Arad"]
  gem.email         = ["zohar@zohararad.com"]
  gem.description   = %q{TODO: Generate Grape API documentation}
  gem.summary       = %q{TODO: Document your Grape API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'grape'
  gem.add_development_dependency 'rspec'
end
