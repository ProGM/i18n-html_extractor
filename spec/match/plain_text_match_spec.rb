# frozen_string_literal: true

describe I18n::HTMLExtractor::Match::PlainTextMatch do
  let(:document) do
    I18n::HTMLExtractor::ErbDocument.parse_string(erb_string)
  end
  let(:node) { document.xpath('./div').first }
  subject { described_class.create(document, node) }

  context 'when parsing plain text' do
    let(:erb_string) { '<div>Some Text</div>' }

    it 'transforms text to erb directive' do
      expect(subject).to be_a(Array)
      subject.compact!
      result = subject.first
      expect(result.text).to eq('Some Text')
      result.replace_text!
      expect(node.text).to match(/^@@=.*@@$/)
      expect(document.erb_directives.keys.count).to eq(1)
    end
  end

  context 'when parsing plain text with spacing' do
    let(:erb_string) { "<div>\n       Some Text  \n    </div>" }

    it 'keeps spacing' do
      expect(subject).to be_a(Array)
      subject.compact!
      result = subject.first
      expect(result.text).to eq('Some Text')
      result.replace_text!
      expect(node.text).to match(/\s+@@=.*@@\s+/)
      expect(document.erb_directives.keys.count).to eq(1)
    end
  end

  context 'when parsing plain text that includes erb' do
    let(:erb_string) { "<div><% if a == b %>\n       Some Text\n      <% end %> Other text</div>" }
    let(:matched_text) { ['Some Text', 'Other text'] }
    it 'matches multiple elements' do
      expect(subject).to be_a(Array)
      subject.compact!
      expect(subject.count).to eq(2)
      subject.each_with_index do |result, i|
        expect(result.text).to eq(matched_text[i])
        result.replace_text!
        expect(node.text).to match(/\s+@@=.*@@\s+/)
      end
      expect(document.erb_directives.keys.count).to eq(4)
    end
  end
end
