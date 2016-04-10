module I18n
  module HTMLExtractor
    module Match
      class PlainTextMatch < BaseMatch
        def self.create(document, node)
          return nil if node.name.start_with?('script')
          node.text.split(/\@\@(=?)[a-z0-9\-]+\@\@/).map! do |text|
            new(document, node, text.strip) unless text.blank?
          end
        end

        def replace_text!
          key = SecureRandom.uuid
          document.erb_directives[key] = translation_key_object
          node.content = node.content.gsub(text, "@@=#{key}@@")
        end
      end
    end
  end
end
