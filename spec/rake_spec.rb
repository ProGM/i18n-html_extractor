input_dir = "#{Rails.root}/spec/input"
output_dir = "#{Rails.root}/spec/output"
tmp_dir = "#{Rails.root}/spec/tmp"

describe 'tasks' do
  before(:each) { FileUtils.copy_entry(input_dir, tmp_dir) }
  after(:each) { FileUtils.rm_rf(tmp_dir) }

  describe 'i18n:extract_html:list' do
    it 'Returns a list of matched data' do
      expect do
        expect do
          Rake::Task['i18n:extract_html:list'].invoke("#{tmp_dir}/*.erb")
        end.to output(%r{Found ".+" in [a-zA-Z/\-.]+}).to_stdout
      end.not_to raise_exception
    end
  end

  describe 'i18n:extract_html:auto' do
    it 'Returns and replaces a list of matched data' do
      expect do
        expect do
          Rake::Task['i18n:extract_html:auto'].invoke("#{tmp_dir}/*.erb")
        end.to output(/Found "Hello".*/).to_stdout
      end.not_to raise_exception

      expect(File.read("#{tmp_dir}/test.html.erb")).to eql(File.read("#{output_dir}/test.html.erb"))
    end
  end

  describe 'i18n:extract_html:interactive' do
    it 'Returns and replaces list of matched data' do
      allow($stdin).to receive(:gets).and_return('y')
      expect do
        expect do
          Rake::Task['i18n:extract_html:interactive'].invoke("#{tmp_dir}/*.erb")
        end.to output(/Found "Hello".*/).to_stdout
      end.to change {
        File.read("#{tmp_dir}/test.html.erb")
      }.to include('<%= link_to _(\'y\') %>')
    end
  end
end
