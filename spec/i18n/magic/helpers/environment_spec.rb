RSpec.describe I18n::Magic::Helpers::Environment do
  describe '#locales' do
    it 'returns an array of available locales within a project using yml translation files with 2 character names only' do
      expect(I18n::Magic::Helpers::Environment.locales('spec/fixtures/files/config/locales/')).to match_array(%w[EN AR RU])
    end
  end
end
