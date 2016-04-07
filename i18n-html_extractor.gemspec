lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'i18n/html_extractor/version'

Gem::Specification.new do |s|
  s.name     = 'i18n-html_extractor'
  s.version  = I18n::HTMLExtractor::VERSION
  s.required_ruby_version = '>= 2.0.0'

  s.authors  = 'Piero Dotti'
  s.email    = 'progiemmeh@gmail.com'
  s.homepage = 'https://github.com/ProGM/i18n-html_extractor'
  s.summary = <<SUMMARY
Rake tasks to extract text from html and put to i18n files.
SUMMARY

  s.license = 'MIT'

  s.description = <<DESCRIPTION
Rake tasks for managing Neo4j
Tasks allow for starting, stopping, and configuring
DESCRIPTION

  s.require_path = 'lib'
  s.files = Dir.glob('{bin,lib,config}/**/*') + %w(README.md Gemfile i18n-html_extractor.gemspec)

  s.add_dependency('i18n')
  s.add_dependency('nokogiri')
  s.add_dependency('colored')
  s.add_dependency('rake')
  s.add_dependency('i18n-tasks')
  s.add_dependency('activesupport', '> 3.2', '< 5.1')
  s.add_dependency('railties', '> 3.2', '< 5.1')

  # s.add_development_dependency('vcr')
  s.add_development_dependency('pry')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('guard')
  s.add_development_dependency('guard-rubocop')
  s.add_development_dependency('rubocop')
end
