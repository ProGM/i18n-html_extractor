[![Build Status](https://travis-ci.org/ProGM/i18n-html_extractor.svg?branch=master)](https://travis-ci.org/ProGM/i18n-html_extractor)

I18n HTML Extractor
---------------

A set of rake tasks to extract strings from html templates into locale files.

# Introduction

I created this gem to resolve a practical problem: I had to deal with a big Rails project that had no i18n locales at all.

It's not yet 100% functional, but I'd like to improve it.

# Installation

It's not yet published as a gem, since it's not ready, but you can start use it by adding it to you Gemfile:

```ruby
gem 'i18n-html_extractor', github: 'ProGM/i18n-html_extractor'
```

# Testing

To run the test suite:
`bin exec rspec`

To keep the test suite and linter running while you develop:
`bin exec guard`

# How it works

It scans all your HTML templates for strings and moves them to locales file.

It's made of three rake tasks:

### List-only Mode

Running `rake i18n:extract_html:list`, you'll get a report of all files that contains strings that should be translated.

### Automatic Mode

Running `rake i18n:extract_html:auto`, all strings are moved to i18n locale file of your default language.

### Interactive Mode

Running `rake i18n:extract_html:interactive`, you can decide, for every string, which one to move to translation, and it's translation for every language.
