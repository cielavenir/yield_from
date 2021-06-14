# coding: utf-8
require './lib/yield_from'

Gem::Specification.new do |spec|
  spec.name          = "yield_from"
  spec.version       = YieldFrom::VERSION
  spec.authors       = ["cielavenir"]
  spec.email         = ["cielartisan@gmail.com"]
  spec.description   = "implementing yield from func() functionality by modifying yield *func() behavior"
  spec.summary       = "implementing yield from func() functionality by modifying yield *func() behavior"
  spec.homepage      = "http://github.com/cielavenir/yield_from"
  spec.license       = "Ruby License (2-clause BSDL or Artistic)"

  spec.files         = `git ls-files`.split($/) + [
    "LICENSE.txt",
    "README.md",
    #"CHANGELOG.md",
  ]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
