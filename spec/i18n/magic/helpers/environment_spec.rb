RSpec.describe I18n::Magic::Helpers::Environment do
  describe '#locales' do
    let(:locale_files_sample_path) { I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH }

    it 'returns an array of available locales within a project using yml translation files with 2 character names only' do
      expect(I18n::Magic::Helpers::Environment.locales(locale_files_sample_path)).to match_array(%w[EN AR RU HI])
    end
  end
end
