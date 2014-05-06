Gem::Specification.new do |spec|
  spec.name          = "lita-webhookr"
  spec.version       = "0.0.1"
  spec.authors       = ["Troy Anderson"]
  spec.email         = ["the.inventor@gmail.com"]
  spec.description   = %q{A Lita handler that will display http messages in the channel}
  spec.summary       = %q{A Lita handler that will display http messages in the channel}
  spec.homepage      = "https://github.com/theinventor/lita-webhookr"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 2.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta2"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"

  spec.metadata = { "lita_plugin_type" => "handler" }
end
