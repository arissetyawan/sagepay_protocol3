# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sagepay_protocol3/version'

Gem::Specification.new do |spec|
  spec.name          = "sagepay_protocol3"
  spec.version       = SagepayProtocol3::VERSION
  spec.authors       = ["Michael de Silva"]
  spec.email         = ["michael@mwdesilva.com"]
  spec.homepage      = "http://mwdesilva.com"
  spec.summary       = "Encryption in Ruby to interface with SagePay's payment gateway protocol v3."
  spec.description   = spec.summary
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails", "~> 3.2.13"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "mocha"
  #spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "redcarpet"
end
