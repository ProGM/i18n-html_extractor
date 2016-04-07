module I18n
  module HTMLExtractor
    module Match
      class PlaceholderMatch < BaseMatch
        def self.create(document, node)
          new(document, node, node['placeholder'])
        end

        def replace_text!
          key = "@@=#{SecureRandom.uuid}@@"
          document.erb_directives[key] = translation_key_object
          node['placeholder'] = key
        end
      end
    end
  end
end
