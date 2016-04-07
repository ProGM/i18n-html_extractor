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

          serialize_erb!(document, file)

          i18n = I18n::Tasks::BaseTask.new

          new_keys = i18n.missing_keys(locales: [I18n.default_locale]).set_each_value!(node.text)
          i18n.data.merge! new_keys
          puts "Added t(.#{node.key}), translated in #{I18n.default_locale} as #{node.text}:".green
          puts new_keys.inspect

          I18n.available_locales.each do |locale|
            next if locale == I18n.default_locale
            answer = nil
            while answer.blank?
              print "Insert translation for #{locale}: "
              answer = STDIN.gets.strip
            end
            new_keys = i18n.missing_keys(locales: [locale.to_s])
                           .set_each_value!(answer)
            i18n.data.merge! new_keys
            puts "Added t(.#{node.key}), translated in #{locale} as #{answer}:".green
            puts new_keys.inspect
          end
          puts
        end
      end

      def run
      end

      def test_run
        each_translation do |file, _, node|
          puts "Found \"#{node.text}\" in #{file}:#{node.text}".green
        end
      end

      private

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
