# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'entity_mapper/version'

Gem::Specification.new do |spec|
  spec.name          = "entity_mapper"
  spec.version       = EntityMapper::VERSION
  spec.authors       = ["Ben Askins"]
  spec.email         = ["ben.askins@gmail.com"]
  spec.description   = %q{Repository for persisting entities}
  spec.summary       = %q{Write something here eventually}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "virtus",      ">= 1.0.0.beta0", "<= 2.0"
  spec.add_dependency "activemodel", ">= 4.0.0.rc1", "< 5"
  spec.add_dependency "hooks"
end
