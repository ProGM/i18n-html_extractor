# frozen_string_literal: true

module I18n
  module HTMLExtractor
    module Match
      class NodeMatch
        attr_reader :document, :text

        def initialize(document, text)
          @document = document
          @text = text
        end

        def translation_key_object
          "_('#{key}')"
        end

        def replace_text!
          raise NotImplementedError
        end

        attr_writer :key

        def key
          @key ||= text.parameterize(preserve_case: true, separator: '_')
        end
      end
    end
  end
end
