describe I18n::HTMLExtractor::Match::Finder do
  let(:document) do
    I18n::HTMLExtractor::ErbDocument.parse_string(erb_string)
  end
  subject { described_class.new(document) }

  let(:matches) { subject.matches }

  context 'when parsing plain text' do
    let(:erb_string) { "<div>\n  Some Text\n  </div>" }

    it 'extracts \"Some Text\"' do
      expect(matches.count).to eq(1)
      expect(matches.first).to be_a(I18n::HTMLExtractor::Match::PlainTextMatch)
      expect(matches.first.text).to eq('Some Text')
    end
  end

  context 'when parsing plain text that includes erb' do
    let(:erb_string) { "<div><% if a == b %>\n       Some Text\n      <% end %> Other text</div>" }

    it 'extracts a list of matches' do
      expect(matches.count).to eq(2)
      matches.each do |match|
        expect(match).to be_a(I18n::HTMLExtractor::Match::PlainTextMatch)
      end
    end
  end
end
