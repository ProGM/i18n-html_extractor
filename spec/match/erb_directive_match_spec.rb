describe I18n::HTMLExtractor::Match::ErbDirectiveMatch do
  let(:document) do
    I18n::HTMLExtractor::ErbDocument.parse_string(erb_string)
  end
  let(:fragment) { document.erb_directives.keys.first }
  subject { described_class.create(document, fragment) }

  context 'when parsing link_to' do
    let(:erb_string) { '<%= link_to "Hello", some_url, title: \'Some title\' %>' }

    it 'extracts both text and title' do
      expect(subject).to be_a(Array)
      subject.compact!
      expect(subject.count).to eq(2)
      subject.map(&:replace_text!)
      expect(document.erb_directives[fragment]).to eq(
        " link_to _('Hello'), some_url, title: _('Some_title') "
      )
    end
  end

  context 'when parsing *_fields' do
    let(:erb_string) { '<%= some.email_field :email, placeholder: "email", class: "some" %>' }

    it 'extracts placeholder' do
      expect(subject).to be_a(Array)
      subject.compact!
      expect(subject.count).to eq(1)
      subject.map(&:replace_text!)
      expect(document.erb_directives[fragment]).to eq(
        ' some.email_field :email, placeholder: _(\'email\'), class: "some" '
      )
    end
  end

  context 'when parsing text_areas' do
    let(:erb_string) { '<%= some.text_area :text, placeholder: "some text", class: "some" %>' }

    it 'extracts placeholder' do
      expect(subject).to be_a(Array)
      subject.compact!
      expect(subject.count).to eq(1)
      subject.map(&:replace_text!)
      expect(document.erb_directives[fragment]).to eq(
        ' some.text_area :text, placeholder: _(\'some_text\'), class: "some" '
      )
    end
  end

  context 'when parsing labels' do
    let(:erb_string) { '<%= some.label :email, "text" %>' }

    it 'extracts text' do
      expect(subject).to be_a(Array)
      subject.compact!
      expect(subject.count).to eq(1)
      subject.map(&:replace_text!)
      expect(document.erb_directives[fragment]).to eq(
        ' some.label :email, _(\'text\') '
      )
    end
  end

  context 'when parsing submit buttons' do
    let(:erb_string) { '<%= some.submit "text" %>' }

    it 'extracts text' do
      expect(subject).to be_a(Array)
      subject.compact!
      expect(subject.count).to eq(1)
      subject.map(&:replace_text!)
      expect(document.erb_directives[fragment]).to eq(
        ' some.submit _(\'text\') '
      )
    end
  end
end
