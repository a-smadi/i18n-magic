RSpec.describe I18n::Magic::Helpers::StringOps do
  describe '#underscore' do
    it 'returns a string containing a snake_case name, when called with a CamelCase name' do
      camel_case_string = 'HelloI18nMagic'
      snake_case_string = 'hello_i18n_magic'
      expect(I18n::Magic::Helpers::StringOps.underscore(camel_case_string)).to eq(snake_case_string)
    end
  end

  describe '#locale' do
    it 'should return a given text`s locale, when the text`s language matches a hardcoded predefined alphabet' do
      expect(I18n::Magic::Helpers::StringOps.locale('Hi, Ruby!!', I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH)).to eq('EN')
    end

    it 'should return a given text`s locale while learning the alphabet from available locale files, when the text`s language does not match hardcoded predefined alphabets' do
      expect(I18n::Magic::Helpers::StringOps.locale('नमस्ते', I18n::Magic::Helpers::Environment::LOCALE_FILES_SAMPLE_PATH)).to eq('HI')
    end
  end

  describe '#letters_only' do
    it 'returns a string containing letters only, when called with a string that has mixed charactes' do
      my_string = 'Hello` there*, my /name\ is: #{JON} "DOE"!!. (How) are \'you\' [doing] $today ? & my %email is <j@doe.me>'
      letters_only_string = 'hellotheremynameisjondoehowareyoudoingtodaymyemailisjdoeme'
      expect(I18n::Magic::Helpers::StringOps.letters_only(my_string)).to eq(letters_only_string)
    end
  end
end
