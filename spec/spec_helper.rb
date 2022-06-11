# frozen_string_literal: true

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
