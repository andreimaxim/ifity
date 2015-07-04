# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'udipity/version'

Gem::Specification.new do |spec|
  spec.name          = "udipity"
  spec.version       = Udipity::VERSION
  spec.authors       = ["Andrei Maxim"]
  spec.email         = ["hi@andmx.im"]

  spec.summary       = %q{Sample UDP client/server/monitor}
  spec.homepage      = "https://andmx.im"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'curses'
  spec.add_dependency 'rainbow', '~> 2.0'
  spec.add_dependency 'redis', '~> 3.2'
  spec.add_dependency 'eventmachine', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
