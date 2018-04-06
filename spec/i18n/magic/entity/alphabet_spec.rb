RSpec.describe I18n::Magic::Entity::Alphabet do
  let(:alphabet) { I18n::Magic::Entity::Alphabet.new }

  describe 'attribute readers' do
    it 'should provide read to :letters' do
      expect(alphabet).to respond_to(:letters)
    end
  end

  describe '#learn' do
    it 'should add unique letters to its letters attribute from the provided strings, with disregard to non-letter characters' do
      alphabet.learn('The, quick    broWn@ fox?!...')
      alphabet.learn('...jumps #over @the $Lazy Dog')
      expect(alphabet.letters).to match_array(%w[a b c d e f g h i j k l m n o p q r s t u v w x y z])
    end
  end

  describe '#belonging_score' do
    it 'should return a score denoting how much (as a percentage) a given string belongs to the current learnt alphabet' do
      alphabet.learn('наука о методах и процессах сбора, хранения, обработки, передачи, анализа и оценки информации с применением компьютерных технологий')
      expect(alphabet.belonging_score('Hello, Mankind !')).to eq(0)
      expect(alphabet.belonging_score('你好，世界')).to eq(0)
      expect(alphabet.belonging_score('программист')).to eq(100)
    end
  end

  describe 'letters from locale' do
    it 'should know the letters in the EN alphabet' do
      en_alphabet = I18n::Magic::Entity::Alphabet.new('EN')
      expect(en_alphabet.letters).to match_array(%w[a b c d e f g h i j k l m n o p q r s t u v w x y z])
    end

    it 'should know the letters in the AR alphabet' do
      ar_alphabet = I18n::Magic::Entity::Alphabet.new('AR')
      expect(ar_alphabet.letters).to match_array(%w[ا ب ج د ه و ز ح ط ي ك ل لا م ن س ع ف ص ق ر ش ت ث خ ذ ض ظ غ])
    end

    it 'should know the letters in the RU alphabet' do
      ru_alphabet = I18n::Magic::Entity::Alphabet.new('RU')
      expect(ru_alphabet.letters).to match_array(%w[а б в г д е ё ж з и й к л м н о п р с т у ф х ц ч ш щ ъ ыь э ю я і ѳ ѣ ѵ ѕ ѯ ѱ ѡ ѫ ѧ ѭ ѩ Ѩ Ѭ Ѧ Ѫ Ѡ Ѱ Ѯ Ѕ Ѵ Ѣ Ѳ І Я Ю Э Ь Ы Ъ Щ Ш Ч Ц Х Ф У П Л Й И З Ж Ё Д Г Б])
    end

    it 'should know the letters in the DE alphabet' do
      de_alphabet = I18n::Magic::Entity::Alphabet.new('DE')
      expect(de_alphabet.letters).to match_array(%w[a b c d e f g h i j k l m n o p q r s t u v w x y z ä ö ü Ä Ö Ü ß])
    end

    it 'should know the letters in the FR alphabet' do
      fr_alphabet = I18n::Magic::Entity::Alphabet.new('FR')
      expect(fr_alphabet.letters).to match_array(%w[a b c d e f g h i j k l m n o p q r s t u v w x y z é è ç ë ò ô ö ù à â])
    end

    it 'should know the letters in the ES alphabet' do
      es_alphabet = I18n::Magic::Entity::Alphabet.new('ES')
      expect(es_alphabet.letters).to match_array(%w[a b c d e é f g h i í j k l m n ñ o ó p q r s t u ú v w x y z])
    end

    it 'should know the letters in the HE alphabet' do
      he_alphabet = I18n::Magic::Entity::Alphabet.new('HE')
      expect(he_alphabet.letters).to match_array(%w[א בּ ב ג ד ה ו ז ח ט י כּ כ ךּ ך ל מ ם נ ן ס ע פּ פ ף צ ץ ק ר שׁ שׂ תּ ת])
    end

    it 'should know the letters in the ZH alphabet' do
      zh_alphabet = I18n::Magic::Entity::Alphabet.new('ZH')
      expect(zh_alphabet.letters).to match_array(%w[ㄅ ㄆ ㄇ ㄈ ㄉ ㄊ ㄋ ㄌ ㄍ ㄎ ㄏ ㄐ ㄑ ㄒ ㄓ ㄔ ㄕ ㄖ ㄗ ㄘ ㄙ ㄚ ㄛ ㄜ ㄝ ㄞ ㄟ ㄠ ㄡ ㄢ ㄣ ㄤ ㄥ ㄦ ㄧ ㄨ ㄩ ㄭ])
    end

    it 'should know the letters in the JA alphabet' do
      ja_alphabet = I18n::Magic::Entity::Alphabet.new('JA')
      expect(ja_alphabet.letters).to match_array(%w[あ い う え お か き く け こ が ぎ ぐ げ ご さ し す せ そ ざ じ ず ぜ ぞ た ち つ て と だ ぢ づ で ど な に ぬ ね の は ひ ふ へ ほ ば び ぶ べ ぼ ぱ ぴ ぷ ぺ ぽ ま み む め も や ゆ よ ら り る れ ろ わ を ん])
    end

    it 'should know the letters in the TR alphabet' do
      tr_alphabet = I18n::Magic::Entity::Alphabet.new('TR')
      expect(tr_alphabet.letters).to match_array(%w[a b c ç d e f g ğ h ı i j k l m n o ö p r s ş t u ü v y z Ü Ş Ö Ğ Ç])
    end
  end
end
