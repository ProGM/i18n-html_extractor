module I18n
  module HTMLExtractor
    module Match
      class PlainTextMatch < BaseMatch
        def self.create(document, node)
          new(document, node, node.text) unless node.name.start_with?('script')
        end

        def replace_text!
          key = "@@=#{SecureRandom.uuid}@@"
          document.erb_directives[key] = translation_key_object
          node.content = key
        end
      end
    end
  end
end
