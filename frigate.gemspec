# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'frigate/version'

Gem::Specification.new do |spec|
  spec.name          = "frigate"
  spec.version       = Frigate::VERSION
  spec.authors       = ["rochdev"]
  spec.email         = ["roch.devost@gmail.com"]

  spec.summary       = "Command-line tool to help manage a docker-compose project"
  spec.description   = "Command-line tool to help manage a docker-compose project"
  spec.homepage      = "https://github.com/rochdev/frigate"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "commander", "~> 4.4"
  spec.add_runtime_dependency "inquirer", "~> 0.2.1"
  spec.add_runtime_dependency "colorize", "~> 0.7.7"

  spec.add_development_dependency "bundler", "~> 1.12.a"
  spec.add_development_dependency "rake", "~> 10.0"
end
