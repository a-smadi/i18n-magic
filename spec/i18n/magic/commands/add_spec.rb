require 'fileutils'

RSpec.describe I18n::Magic::Commands::Add do
  describe '#execute' do
    let(:add_command)          { I18n::Magic::Commands::Add.new(key: 'hello_world', values: ['Hello, World!'], locale_files_path: I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH) }
    let(:en_file_path)         { "#{I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH}en.yml" }
    let(:en_default_file_path) { "#{I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH}defaults.en.yml" }

    it 'should add the given value to the appropriate localization file, for the given key' do
      file = File.open(en_file_path, 'r')
      expect { add_command.execute
               file = File.open(en_file_path, 'r')
      }.to change { file.readlines.size }.by 1
      FileUtils.cp(en_default_file_path, en_file_path)
    end
  end
end
