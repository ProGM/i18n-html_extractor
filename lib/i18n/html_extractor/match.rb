require 'i18n/html_extractor/match/node_match'
require 'i18n/html_extractor/match/base_match'
require 'i18n/html_extractor/match/erb_directive_match'
require 'i18n/html_extractor/match/placeholder_match'
require 'i18n/html_extractor/match/plain_text_match'
module I18n
  module HTMLExtractor
    module Match
      class Finder
        attr_reader :document

        def initialize(document)
          @document = document
        end

        def matches
          erb_nodes(document) + plain_text_nodes(document) + form_fields(document)
        end

        private

        def erb_nodes(document)
          document.erb_directives.map do |fragment_id, _|
            ErbDirectiveMatch.create(document, fragment_id)
          end.compact
        end

        def plain_text_nodes(document)
          leaf_nodes.reject { |n| n.text =~ /\@\@(=?)[a-z0-9\-]+\@\@/ }
                    .map! { |node| PlainTextMatch.create(document, node) }.compact
        end

        def form_fields(document)
          document.css('textarea[placeholder],input[placeholder]').select { |input| input['placeholder'].present? }
                  .reject { |n| n['placeholder'] =~ /\@\@(=?)[a-z0-9\-]+\@\@/ }
                  .map! do |node|
            PlaceholderMatch.create(document, node)
          end
        end

        def leaf_nodes
          @leaf_nodes ||= document.css('*:not(:has(*))').select { |n| n.text.present? }
        end
      end
    end
  end
end
