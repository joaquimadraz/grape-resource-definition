# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resource_definition/version'

Gem::Specification.new do |gem|
  gem.name          = "grape_resource_definition"
  gem.version       = ResourceDefinition::VERSION
  gem.authors       = ["Joaquim Adráz"]
  gem.email         = ["joaquim.adraz@gmail.com"]
  gem.description   = %q{Grape Resource Definition}
  gem.summary       = %q{Grape Resource Definition}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "grape", ["= 0.9.0"]

  #development dependecy
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-core", '2.14.8'
  gem.add_development_dependency "rake"
  gem.add_development_dependency "pry"
end