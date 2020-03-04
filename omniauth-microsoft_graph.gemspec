# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/microsoft_graph/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-microsoft_graph'
  spec.version       = Omniauth::MicrosoftGraph::VERSION
  spec.authors       = ["Matthias H\xC3\xA4hnel"]
  spec.email         = ['matthias.haehnel@sixt.com']
  spec.summary       = 'omniauth provider for Microsoft Graph'
  spec.description   = 'omniauth OAuth2 provider for the Microsoft Graph API'
  spec.homepage      = 'https://github.com/m4c3/omniauth-microsoft_graph'
  spec.license       = 'MIT'

  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {spec}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
