require_relative '../helpers/string_ops'

module I18n
  module Magic
    module Entity
      class Alphabet
        attr_reader :letters

        EN_LETTERS = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z].freeze
        AR_LETTERS = %w[ا ب ج د ه و ز ح ط ي ك ل لا م ن س ع ف ص ق ر ش ت ث خ ذ ض ظ غ].freeze
        RU_LETTERS = %w[а б в г д е ё ж з и й к л м н о п р с т у ф х ц ч ш щ ъ ыь э ю я і ѳ ѣ ѵ ѕ ѯ ѱ ѡ ѫ ѧ ѭ ѩ Ѩ Ѭ Ѧ Ѫ Ѡ Ѱ Ѯ Ѕ Ѵ Ѣ Ѳ І Я Ю Э Ь Ы Ъ Щ Ш Ч Ц Х Ф У П Л Й И З Ж Ё Д Г Б].freeze
        DE_LETTERS = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z ä ö ü Ä Ö Ü ß].freeze
        FR_LETTERS = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z é è ç ë ò ô ö ù à â].freeze
        ES_LETTERS = %w[a b c d e é f g h i í j k l m n ñ o ó p q r s t u ú v w x y z].freeze
        HE_LETTERS = %w[א בּ ב ג ד ה ו ז ח ט י כּ כ ךּ ך ל מ ם נ ן ס ע פּ פ ף צ ץ ק ר שׁ שׂ תּ ת].freeze
        ZH_LETTERS = %w[ㄅ ㄆ ㄇ ㄈ ㄉ ㄊ ㄋ ㄌ ㄍ ㄎ ㄏ ㄐ ㄑ ㄒ ㄓ ㄔ ㄕ ㄖ ㄗ ㄘ ㄙ ㄚ ㄛ ㄜ ㄝ ㄞ ㄟ ㄠ ㄡ ㄢ ㄣ ㄤ ㄥ ㄦ ㄧ ㄨ ㄩ ㄭ].freeze
        JA_LETTERS = %w[あ い う え お か き く け こ が ぎ ぐ げ ご さ し す せ そ ざ じ ず ぜ ぞ た ち つ て と だ ぢ づ で ど な に ぬ ね の は ひ ふ へ ほ ば び ぶ べ ぼ ぱ ぴ ぷ ぺ ぽ ま み む め も や ゆ よ ら り る れ ろ わ を ん].freeze
        TR_LETTERS = %w[a b c ç d e f g ğ h ı i j k l m n o ö p r s ş t u ü v y z Ü Ş Ö Ğ Ç].freeze

        def initialize(locale = nil)
          @letters = eval("#{locale.upcase}_LETTERS") rescue %w[]
        end

        def learn(sample_text)
          return unless sample_text.present? && sample_text.size.positive?
          normalized_text = I18n::Magic::Helpers::StringOps.letters_only(sample_text).downcase
          normalized_text.chars.each { |character| @letters.push(character) unless @letters.include?(character) }
        end

        def belonging_score(text)
          score = 0
          normalized_text = I18n::Magic::Helpers::StringOps.letters_only(text).downcase
          return 0 unless normalized_text.present? && normalized_text.size.positive?
          normalized_text.chars.each { |character| score += (100.0 / normalized_text.size) if @letters.include?(character) }
          score.to_i
        end
      end
    end
  end
end
