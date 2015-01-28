# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sj_ignore/version'

Gem::Specification.new do |spec|
  spec.name          = "sj_ignore"
  spec.version       = SjIgnore::VERSION
  spec.authors       = ["sjdev"]
  spec.email         = ["shane@gianel.li"]
  spec.summary       = "Easy command line utility to create a multi-faceted .gitignore file"
  spec.description   = "sj-ignore uses github's gitignore repository to make it easy to list all the languages and platforms you would like included in your .gitignore file"
  spec.homepage      = "https://github.com/sjdev/sj-ignore"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['sj_ignore']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "github_api", "~> 0.12.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
