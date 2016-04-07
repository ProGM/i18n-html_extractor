require 'nokogiri'

module I18n
  module HTMLExtractor
    class ErbDocument
      attr_reader :erb_directives
      def initialize(document, erb_directives)
        @document = document
        @erb_directives = erb_directives
      end

      def serialize(filename)
        File.open(filename, 'w') do |f|
          result = doc.to_html(indent: 2, encoding: 'UTF-8')
          result.gsub!(/@@=([a-z0-9\-]+)@@/) do |data|
            "<%= #{doc.erb_directives[data].strip} %>"
          end
          result.gsub!(/@@#([a-z0-9\-]+)@@/) do |data|
            "<%# #{doc.erb_directives[data].strip} %>"
          end
          result.gsub!(/@@([a-z0-9\-]+)@@/) do |data|
            "<% #{doc.erb_directives[data].strip} %>"
          end
          f.write result
        end
      end

      def method_missing(name, *args, &block)
        @document.public_send(name, *args, &block) if @document.respond_to? name
      end

      class <<self
        def parse(filename, verbose: false)
          document = nil
          file_content = ''
          erb_directives = {}
          File.open(filename) do |file|
            file.read(nil, file_content)

            erb_directives = extract_erb_directives! file_content

            document = if file_content.start_with?('<!DOCTYPE')
                         Nokogiri::HTML(file_content)
                       else
                         Nokogiri::HTML.fragment(file_content)
                       end
          end
          log_errors(document.errors, file_content) if verbose
          ErbDocument.new(document, erb_directives)
        end

        private

        def log_errors(errors, file_content)
          return if errors.empty?
          text = file_content.split("\n")
          errors.each do |e|
            puts "Error at line #{e.line}: #{e}".red
            puts text[e.line - 1]
          end
        end

        ERB_REGEXPS = [/<%=(.+?)%>/m, /<%#(.+?)%>/m, /<%(.+?)%>/m].freeze
        ERB_PATTERNS = ['@@=%s@@', '@@#%s@@', '@@%s@@'].freeze

        def extract_erb_directives!(text)
          erb_directives = {}
          ERB_REGEXPS.each_with_index do |regexp, i|
            text.gsub!(regexp) do
              key = ERB_PATTERNS[i] % SecureRandom.uuid
              erb_directives[key] = Regexp.last_match(1)
              key
            end
          end
          erb_directives
        end
      end
    end
  end
end
