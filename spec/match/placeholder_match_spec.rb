# frozen_string_literal: false

describe I18n::HTMLExtractor::Match::PlaceholderMatch do
  let(:document) do
    I18n::HTMLExtractor::ErbDocument.parse_string(text)
  end
  let(:node) { document.xpath('./div/*').first }
  subject { described_class.create(document, node) }

  context 'when matching inputs' do
    let(:text) { '<div><input placeholder="Some text"></div>' }

    it 'extracts the placeholder' do
      expect(subject).to be_a(Array)
      subject.compact!
      result = subject.first
      expect(result.text).to eq('Some text')
      result.replace_text!
      expect(node['placeholder']).to match(/^@@=.*@@$/)
      expect(document.erb_directives.keys.count).to eq(1)
    end
  end

  context 'when matching textareas' do
    let(:text) { '<div><textarea placeholder="Some text"></textarea></div>' }

    it 'extracts the placeholder' do
      expect(subject).to be_a(Array)
      subject.compact!
      result = subject.first
      expect(result.text).to eq('Some text')
      result.replace_text!
      expect(node['placeholder']).to match(/^@@=.*@@$/)
      expect(document.erb_directives.keys.count).to eq(1)
    end
  end
end
