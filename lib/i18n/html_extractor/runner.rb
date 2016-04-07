module I18n
  module HTMLExtractor
    class Runner
      include Cli

      def initialize(args = {})
        @files = if args[:file_pattern]
                   Dir[Rails.root.join(args[:file_pattern])]
                 else
                   Dir[Rails.root.join('app', 'views', '**', '*.erb')] -
                     Dir[Rails.root.join('app', 'views', '**', '*.*.*.erb')]
                 end
        @verbose = args[:verbose]
      end

      def run_interactive
        each_translation do |file, document, node|
          puts "Found \"#{node.text}\" in #{file}:#{node.text}".green
          next unless confirm 'Create a translation?', 'Yes', 'No', default: 'Yes'

          node.key = prompt 'Choose i18n key', default: node.key
          node.replace_text!

          document.save!(file)

          add_translations! node.key, node.text
          puts
        end
      end

      def run
        each_translation do |file, document, node|
          puts "Found \"#{node.text}\" in #{file}:#{node.text}".green
          node.replace_text!
          document.save!(file)

          add_translation! I18n.default_locale, node.key, node.text
        end
      end

      def test_run
        each_translation do |file, _, node|
          puts "Found \"#{node.text}\" in #{file}:#{node.text}".green
        end
      end

      private

      def add_translations!(key, text)
        default_text = prompt "Choose #{I18n.default_locale} value", default: text
        add_translation! I18n.default_locale, key, default_text

        I18n.available_locales.each do |locale|
          next if locale == I18n.default_locale

          text = prompt "Choose #{locale} value"

          add_translation! locale.to_s, key, text
        end
      end

      def add_translation!(locale, key, value)
        new_keys = i18n.missing_keys(locales: [locale]).set_each_value!(value)
        i18n.data.merge! new_keys
        puts "Added t(.#{key}), translated in #{locale} as #{value}:".green
        puts new_keys.inspect
      end

      def i18n
        I18n::Tasks::BaseTask.new
      end

      def each_translation
        @files.each do |file|
          document = I18n::HTMLExtractor::ErbDocument.parse file
          nodes_to_translate = extract_all_nodes_to_translate(document)
          nodes_to_translate.each { |node| yield(file, document, node) }
        end
      end

      def extract_all_nodes_to_translate(document)
        Match::Finder.new(document).matches
      end
    end
  end
end
