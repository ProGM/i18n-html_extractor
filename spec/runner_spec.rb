input_dir = "#{Rails.root}/spec/input"
tmp_dir = "#{Rails.root}/spec/tmp"

describe I18n::HTMLExtractor::Runner do
  before(:each) { FileUtils.copy_entry(input_dir, tmp_dir) }
  after(:each) { FileUtils.rm_rf(tmp_dir) }

  let(:file) { "#{tmp_dir}/test.html.erb" }
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
