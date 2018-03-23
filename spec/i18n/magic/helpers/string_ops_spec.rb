RSpec.describe I18n::Magic::Helpers::StringOps do
  describe '#underscore' do
    it 'returns a string containing a snake_case name, when called with a CamelCase name' do
      camel_case_string = 'HelloI18nMagic'
      snake_case_string = 'hello_i18n_magic'
      expect(I18n::Magic::Helpers::StringOps.underscore(camel_case_string)).to eq(snake_case_string)
    end
  end

  describe '#letters_only' do
    it 'returns a string containing letters only, when called with a string that has mixed charactes' do
      my_string = 'hello there, my name is jon doe!!'
      letters_only_string = 'hellotheremynameisjondoe'
      expect(I18n::Magic::Helpers::StringOps.letters_only(my_string)).to eq(letters_only_string)
    end
  end
end
