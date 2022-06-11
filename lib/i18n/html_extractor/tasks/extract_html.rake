# frozen_string_literal: true

namespace :i18n do
  namespace :extract_html do
    task :interactive, [:file_pattern, :locale] do |_, args|
      i18n = I18n::Tasks::BaseTask.new

      missing_translations = i18n.missing_keys

      if missing_translations.any?
        raise "There are some translation missing. Fix before running this task:\n\n"\
             "#{missing_translations.inspect}".red
      end
      cli = I18n::HTMLExtractor::Runner.new args
      cli.run_interactive
    end

    task :list, [:file_pattern] do |_, args|
      i18n = I18n::Tasks::BaseTask.new

      missing_translations = i18n.missing_keys

      if missing_translations.any?
        raise "There are some translation missing. Fix before running this task:\n\n"\
             "#{missing_translations.inspect}".red
      end

      cli = I18n::HTMLExtractor::Runner.new args
      cli.test_run
    end

    task :auto, [:file_pattern] do |_, args|
      i18n = I18n::Tasks::BaseTask.new

      missing_translations = i18n.missing_keys

      if missing_translations.any?
        raise "There are some translation missing. Fix before running this task:\n\n"\
             "#{missing_translations.inspect}".red
      end

      cli = I18n::HTMLExtractor::Runner.new args
      cli.run
    end
  end
end
