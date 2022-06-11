# frozen_string_literal: true

SPEC_DIR = 'spec/tmp/folder/minimal'

describe 'tasks' do
  before(:each) { FileUtils.cp_r("#{Rails.root}/spec/files", "#{Rails.root}/spec/tmp") }
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
          expect do
            Rake::Task['i18n:extract_html:auto'].invoke("#{SPEC_DIR}/*.erb")
          end.to output(/Found "Hello".*/).to_stdout
        end.not_to raise_exception
      end.to change {
        File.read("#{SPEC_DIR}/file.html.erb")
      }.to('<%= link_to t(\'.hello\') %>').and change {
        File.read("#{SPEC_DIR}/bug.html.erb")
      }.to('<div><%=t(\'.hello\')%></div>')
    end
  end

  describe 'i18n:extract_html:interactive' do
    it 'Returns and replaces list of matched data' do
      allow($stdin).to receive(:gets).and_return('y')
      expect do
        expect do
          Rake::Task['i18n:extract_html:interactive'].invoke("#{SPEC_DIR}/minimal/*.erb")
        end.to output(/Found "Hello".*/).to_stdout
      end.to change {
        File.read("#{SPEC_DIR}/minimal/file.html.erb")
      }.to('<%= link_to t(\'.y\') %>').and(change do
        File.read("#{SPEC_DIR}/minimal/bug.html.erb")
      end.to('<div><%=t(\'.y\')%></div>'))
    end
  end
end
