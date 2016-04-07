module I18n
  module HTMLExtractor
    module Cli
      def prompt(message, default: nil)
        answer = nil
        while answer.blank?
          print "#{message} #{format_default(default)}:"
          answer = STDIN.gets.chomp.presence || default
        end
        answer
      rescue Interrupt
        exit 1
      end

      def confirm(message, positive, negative, default: nil)
        loop do
          print "#{message} #{format_answers(positive, negative)}: "
          answer = STDIN.gets.chomp.presence || default
          return true if match_answer?(positive, answer)
          return false if match_answer?(negative, answer)
          puts "Invalid answer. Please insert #{formatted_positive} or #{formatted_negative}".red
        end
      rescue Interrupt
        exit 1
      end

      private

      def format_default(default)
        default ? "(default: #{default.yellow})" : ''
      end

      def format_answers(positive, negative)
        "[(#{positive[0].green})#{positive[1..-1]}/(#{negative[0].red})#{negative[1..-1]}]"
      end

      def match_answer?(expected, got)
        expected.downcase.strip == got.downcase.strip ||
          expected[0].to_s.casecmp(got.downcase).zero?
      end
    end
  end
end
