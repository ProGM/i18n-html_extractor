module I18n
  module HTMLExtractor
    module Match
      class ErbDirectiveMatch < NodeMatch
        REGEXPS = [
          [/^([ \t]*link_to )(("[^"]+")|('[^']+'))/, '\1%s', 2],
          [/^([ \t]*link_to (.*),[ ]?title:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*[a-z_]+\.[a-z_]+_field (.*),[ ]?placeholder:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*[a-z_]+\.submit )(("[^"]+")|('[^']+'))/, '\1%s', 2]
        ].freeze

        def initialize(document, fragment_id, text, regexp)
          super(document, text)
          @fragment_id = fragment_id
          @regexp = regexp
        end

        def replace_text!
          document.erb_directives[@fragment_id].gsub!(@regexp[0], @regexp[1] % translation_key_object)
        end

        def self.create(document, fragment_id)
          REGEXPS.each do |r|
            match = document.erb_directives[fragment_id].match(r[0])
            return new(document, fragment_id, match[r[2]][1...-1], r) if match && match[r[2]]
          end
          nil
        end
      end
    end
  end
end
