describe I18n::HTMLExtractor::Match::AriaMatch do
  let(:document) do
    I18n::HTMLExtractor::ErbDocument.parse_string(el)
  end
  let(:node) { document.xpath('./div/*').first }
  subject { described_class.create(document, node) }

  context 'when parsing aria-label' do
    let(:el) do
      '<div><button aria-label="A label">button body</button></div>
      '
    end

    it 'extracts the aria label' do
      expect(subject).to be_a(Array)
      subject.compact!
      expect(subject.count).to eq(1)
      subject.map(&:replace_text!)
      expect(node['aria-label']).to match(/^@@=.*@@$/)
      expect(document.erb_directives.keys.count).to eq(1)
    end
  end
end
