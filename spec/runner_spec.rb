describe I18n::HTMLExtractor::Runner do
  let(:folder) { 'spec/input/*.erb' }
  subject { described_class.new(file_pattern: folder) }

  describe '#run' do
    it 'replaces text in files' do
      skip 'TODO'
    end

    it 'outputs strings to translate in specified string' do
      skip 'TODO'
    end
  end

  describe '#run_interactive' do
    it 'replaces text in files' do
      skip 'TODO'
    end

    it 'outputs strings to translate in specified string' do
      skip 'TODO'
    end
  end

  describe '#test_run' do
    it 'lists all files that contains text to be extracted' do
      expect { subject.test_run }.to output(%r{Found ".+" in [a-zA-Z/\-.]+}).to_stdout
    end
  end
end
