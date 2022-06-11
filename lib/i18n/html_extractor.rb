# frozen_string_literal: true

require 'i18n/html_extractor/two_way_regexp'
require 'i18n/html_extractor/erb_document'
require 'i18n/html_extractor/cli'
require 'i18n/html_extractor/runner'
require 'i18n/html_extractor/match'
require 'active_support/core_ext/object/blank'
require 'colored'
require 'rake'
require 'rails'
require 'i18n/tasks'
load 'i18n/html_extractor/tasks/extract_html.rake'
