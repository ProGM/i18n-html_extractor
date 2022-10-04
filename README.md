i18n HTML Extractor
---------------

A set of rake tasks to extract strings from html templates into locale files.

# Introduction

This gem was forked from [ProGM/i18n-html-extractor](https://github.com/ProGM/i18n-html_extractor) to develop specific features for a codebase that might not be useful for everyone.

# Installation

It's not yet published as a gem, since it's not ready, but you can start use it by adding it to you Gemfile:

```ruby
gem 'i18n-html_extractor', github: 'jamieshark/i18n-html_extractor'
```

# Testing

To run the test suite:
`bin exec rspec`

To keep the test suite and linter running while you develop:
`bin exec guard`

# How it works

It scans all your HTML templates for strings and moves them to locales file.

It has the following available tasks:

### List-only Mode

Running `rake i18n:extract_html:list`, you'll get a report of all files that contains strings that should be translated.

### Automatic Mode

Running `rake i18n:extract_html:auto`, all strings are moved to i18n locale file of your default language.

### Interactive Mode

Running `rake i18n:extract_html:interactive`, you can decide, for every string, which one to move to translation, and it's translation for every language.
