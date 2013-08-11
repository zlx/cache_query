# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cache_query/version'

Gem::Specification.new do |spec|
  spec.name          = "cache_query"
  spec.version       = CacheQuery::VERSION
  spec.authors       = ["soffolk"]
  spec.email         = ["zlx.star@gmail.com"]
  spec.description   = %q{Cache Every Query}
  spec.summary       = %q{Cache Every Query}
  spec.homepage      = "https://github.com/zlx/cache_query"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "> 3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
