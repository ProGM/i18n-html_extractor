# To run coverage via travis
# require 'coveralls'
# Coveralls.wear!

# require 'vcr'
# VCR.configure do |config|
#   config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
#   config.hook_into :webmock
# end

require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'i18n/html_extractor'

module Testing
  class Application < Rails::Application
  end
end

Rails.application.initialize!
Testing::Application.load_tasks

RSpec.configure do |_config|
end
