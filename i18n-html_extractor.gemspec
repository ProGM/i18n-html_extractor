# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'i18n/html_extractor/version'

Gem::Specification.new do |s|
  s.name     = 'i18n-html_extractor'
  s.version  = I18n::HTMLExtractor::VERSION
  s.required_ruby_version = '>= 2.6'

  s.authors  = 'Piero Dotti'
  s.email    = 'progiemmeh@gmail.com'
  s.homepage = 'https://github.com/ProGM/i18n-html_extractor'
  s.summary = <<~SUMMARY
    Rake tasks to extract text from html and put to i18n files.
  SUMMARY

  s.license = 'MIT'

  s.description = <<~DESCRIPTION
    Rake tasks for managing Neo4j
    Tasks allow for starting, stopping, and configuring
  DESCRIPTION

  s.require_path = 'lib'
  s.files = Dir.glob('{bin,lib,config}/**/*') + %w[README.md Gemfile i18n-html_extractor.gemspec]

  s.add_dependency('activesupport', '~> 7.0')
  s.add_dependency('colored', '~> 1.2')
  s.add_dependency('i18n', '~> 1.12')
  s.add_dependency('i18n-tasks', '~> 1.0')
  s.add_dependency('nokogiri', '~> 1.13')
  s.add_dependency('railties', '~> 7.0')
  s.add_dependency('rake', '~> 13.0')

  s.add_development_dependency('guard', '~> 2.18')
  s.add_development_dependency('guard-rubocop', '~> 1.5')
  s.add_development_dependency('pry', '~> 0.14')
  s.add_development_dependency('rubocop', '~> 1.32')
  s.add_development_dependency('simplecov', '~> 0.21')
end
