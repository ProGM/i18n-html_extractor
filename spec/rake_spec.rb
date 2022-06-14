spec_dir = "#{Rails.root}/spec/tmp/folder/minimal"
output_dir = "#{Rails.root}/spec/output"

describe 'tasks' do
  before(:each) { FileUtils.copy_entry("#{Rails.root}/spec/files", "#{Rails.root}/spec/tmp") }
  after(:each) { FileUtils.rm_rf("#{Rails.root}/spec/tmp") }

  describe 'i18n:extract_html:list' do
    it 'Returns a list of matched data' do
      expect do
        expect do
          Rake::Task['i18n:extract_html:list'].invoke('spec/tmp/**/*.erb')
        end.to output(%r{Found ".+" in [a-zA-Z/\-.]+}).to_stdout
      end.not_to raise_exception
    end
  end

  describe 'i18n:extract_html:auto' do
    it 'Returns and replaces a list of matched data' do
      expect do
        expect do
          Rake::Task['i18n:extract_html:auto'].invoke("#{spec_dir}/*.erb")
        end.to output(/Found "Hello".*/).to_stdout
      end.not_to raise_exception

      expect(File.read("#{spec_dir}/file.html.erb")).to eql(File.read("#{output_dir}/file.html.erb"))
    end
  end

  # describe 'i18n:extract_html:interactive' do
  #   it 'Returns and replaces list of matched data' do
  #     allow($stdin).to receive(:gets).and_return('y')
  #     expect do
  #       expect do
  #         Rake::Task['i18n:extract_html:interactive'].invoke("#{spec_dir}/*.erb")
  #       end.to output(/Found "Hello".*/).to_stdout
  #     end.to change {
  #       File.read("#{spec_dir}/file.html.erb")
  #     }.to('<%= link_to t(\'.y\') %>').and(change do
  #       File.read("#{spec_dir}/bug.html.erb")
  #     end.to('<div><%=t(\'.y\')%></div>'))
  #   end
  # end
end
