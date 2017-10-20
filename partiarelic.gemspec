# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'partiarelic/version'

Gem::Specification.new do |spec|
  spec.name          = 'partiarelic'
  spec.version       = Partiarelic::VERSION
  spec.authors       = ['wata']
  spec.email         = ['wata.gm@gmail.com']

  spec.summary       = %q{Rack middleware and application to enable NewRelic agent.}
  spec.description   = %q{Rack middleware and application to enable NewRelic agent.}
  spec.homepage      = 'https://github.com/wata-gh/partiarelic'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'newrelic_rpm'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rack-test', '~> 0.6.3'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'

  spec.add_dependency 'rack'
end
