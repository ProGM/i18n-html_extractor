describe I18n::HTMLExtractor::Runner do
  before(:each) do
    FileUtils.mkdir_p("#{Rails.root}/spec/tmp")
    FileUtils.copy_entry("#{Rails.root}/spec/input/runner.html.erb", "#{Rails.root}/spec/tmp/runner.html.erb")
  end
  # after(:each) { FileUtils.rm_rf("#{Rails.root}/spec/tmp") }

  let(:file) { 'spec/tmp/runner.html.erb' }
  subject { described_class.new(file_pattern: file) }

  describe '#run' do
    it 'replaces text in files' do
      expect { subject.run }.to output(%r{Found ".+" in [a-zA-Z/\-.]+}).to_stdout

      pp subject.run
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
