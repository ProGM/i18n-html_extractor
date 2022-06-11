# frozen_string_literal: true

module I18n
  module HTMLExtractor
    module Match
      class AriaLabelMatch < BaseMatch
        def self.create(document, node)
          if node['aria-label'].present?
            [new(document, node, node['aria-label'])]
          else
            []
          end
        end

        def replace_text!
          key = SecureRandom.uuid
          document.erb_directives[key] = translation_key_object
          node['aria-label'] = "@@=#{key}@@"
        end
      end
    end
  end
end
