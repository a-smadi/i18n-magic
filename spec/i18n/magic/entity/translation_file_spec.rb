RSpec.describe I18n::Magic::Entity::TranslationFile do
  let(:locale_files_sample_path)    { I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH }
  let(:translation_file)            { I18n::Magic::Entity::TranslationFile.new('EN', locale_files_sample_path) }
  let(:inexistent_translation_file) { I18n::Magic::Entity::TranslationFile.new('IT', locale_files_sample_path) }

  describe '#exists?' do
    it 'should return true when localization file exists for the given locale' do
      expect(translation_file.exists?).to be true
    end

    it 'should return false when localization file does not exist for the given locale' do
      expect(inexistent_translation_file.exists?).to be false
    end
  end

  describe '#add' do
    let(:translation_record_for_existing_key) { I18n::Magic::Entity::TranslationRecord.new('say_hi', 'Hello World! My name is %{name}') }
    let(:translation_record)                  { I18n::Magic::Entity::TranslationRecord.new('hello_world', 'Hello World! My name is %{name}') }
    let(:en_file_path)                        { "#{I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH}en.yml" }
    let(:en_default_file_path)                { "#{I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH}defaults.en.yml" }

    after(:each) do
      FileUtils.cp(en_default_file_path, en_file_path)
    end

    it 'should not add a translation to the file for an existing key' do
      file = File.open(en_file_path, 'r')
      expect { translation_file.add(translation_record_for_existing_key)
               file = File.open(en_file_path, 'r')
      }.to change { file.readlines.size }.by (0)
    end

    it 'should add a translation to the file for a non-existing key' do
      file = File.open(en_file_path, 'r')
      expect { translation_file.add(translation_record)
               file = File.open(en_file_path, 'r')
      }.to change { file.readlines.size }.by (1)
    end
  end

  describe '#compatibility_score' do
    it 'should return a percentage denoting how much a given text belongs to this files alphabet set' do
      expect(translation_file.compatibility_score('مرحبا')).to be_zero
      expect(translation_file.compatibility_score('I18n Magic is the best !!')).to eq(100)
    end
  end
end
