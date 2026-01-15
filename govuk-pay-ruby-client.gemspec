# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payments_api/version'

Gem::Specification.new do |spec|
  spec.name     = 'govuk-pay-ruby-client'
  spec.version  = PaymentsApi::VERSION

  spec.authors  = ['Jesus Laiz']
  spec.email    = ['zheileman@users.noreply.github.com']

  spec.summary  = 'Ruby client for GOV.UK Pay API (basic functionality)'
  spec.homepage = 'https://github.com/ministryofjustice/govuk-pay-ruby-client'
  spec.license  = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = Gem::Requirement.new('>= 3.4.8')

  spec.add_dependency 'faraday', '~> 2.0'

  spec.add_development_dependency 'base64', '~> 0.2.0'
  spec.add_development_dependency 'bundler', '~> 4.0.3'
  spec.add_development_dependency 'ostruct', '~> 0.6.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 1.60'
  spec.add_development_dependency 'simplecov', '~> 0.18'
end
