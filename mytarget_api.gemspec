# encoding: utf-8
$: << File.expand_path('../lib', __FILE__)
require 'mytarget_api/version'

Gem::Specification.new do |s|
  s.name        = 'mytarget_api'
  s.version     = MytargetApi::VERSION
  s.authors     = ['Andrey Yuferov']
  s.email       = ['asjuferov@gmail.com']
  s.homepage    = 'https://github.com/tom-orrow/mytarget_api'
  s.summary     = %q{Ruby wrapper for MyTarget API}
  s.description = %q{A transparent wrapper for MyTarget API.}

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency 'faraday',                     '~> 0.9.0'
  s.add_runtime_dependency 'faraday_middleware',          '~> 0.9.1'
  s.add_runtime_dependency 'faraday_middleware-parse_oj', '~> 0.3'
  s.add_runtime_dependency 'oauth2',                      '>= 0.8'
  s.add_runtime_dependency 'hashie',                      '>= 2.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'mechanize'
  s.add_development_dependency 'rb-fsevent', '~> 0.9.1'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'awesome_print'

  s.add_development_dependency 'yard'
  s.add_development_dependency 'redcarpet'
end
