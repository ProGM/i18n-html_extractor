describe 'tasks' do
  before(:each) { FileUtils.cp_r("#{Rails.root}/spec/files", "#{Rails.root}/spec/tmp") }
  after(:each) { FileUtils.rm_rf("#{Rails.root}/spec/tmp") }

  describe 'i18n:extract_html:list' do
    it 'Returns a list of matched data' do
      expect do
        expect do
          Rake::Task['i18n:extract_html:list'].invoke('spec/tmp/**/*.erb')
        end.to output(%r{Found ".+" in [a-zA-Z\/\-\.]+}).to_stdout
      end.not_to raise_exception
    end
  end

  describe 'i18n:extract_html:auto' do
    it 'Returns a list of matched data' do
      expect do
        expect do
          expect do
            Rake::Task['i18n:extract_html:auto'].invoke('spec/tmp/folder/minimal/*.erb')
          end.to output(/Found "Hello".*/).to_stdout
        end.not_to raise_exception
      end.to change { File.read('spec/tmp/folder/minimal/file.html.erb') }.to('<%= link_to t(\'.hello\') %>')
    end
  end

  describe 'i18n:extract_html:interactive' do
    it 'Returns a list of matched data' do
      allow(STDIN).to receive(:gets).and_return('y')
      expect do
        expect do
          Rake::Task['i18n:extract_html:interactive'].invoke('spec/tmp/folder/minimal/*.erb')
        end.to output(/Found "Hello".*/).to_stdout
      end.to change { File.read('spec/tmp/folder/minimal/file.html.erb') }.to('<%= link_to t(\'.y\') %>')
    end
  end
end
