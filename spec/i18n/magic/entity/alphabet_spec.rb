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
      expect(alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::EN_LETTERS)
    end
  end

  describe '#belonging_score' do
    it 'should return a score denoting how much (as a percentage) a given string belongs to the current learnt alphabet' do
      alphabet.learn('наука о методах и процессах сбора, хранения, обработки, передачи, анализа и оценки информации с применением компьютерных технологий')
      expect(alphabet.belonging_score('Hello, Mankind !')).to eq(0)
      expect(alphabet.belonging_score('你好，世界')).to eq(0)
      expect(alphabet.belonging_score('программист')).to eq(100)
      ja_alphabet = I18n::Magic::Entity::Alphabet.new('JA')
      expect(ja_alphabet.belonging_score('hey! whatsup?')).to eq(0)
      expect(ja_alphabet.belonging_score('されるほど')).to eq(100)
    end
  end

  describe 'letters from locale' do
    let(:en_alphabet) { I18n::Magic::Entity::Alphabet.new('EN') }
    let(:ar_alphabet) { I18n::Magic::Entity::Alphabet.new('AR') }
    let(:ru_alphabet) { I18n::Magic::Entity::Alphabet.new('RU') }
    let(:de_alphabet) { I18n::Magic::Entity::Alphabet.new('DE') }
    let(:fr_alphabet) { I18n::Magic::Entity::Alphabet.new('FR') }
    let(:es_alphabet) { I18n::Magic::Entity::Alphabet.new('ES') }
    let(:he_alphabet) { I18n::Magic::Entity::Alphabet.new('HE') }
    let(:zh_alphabet) { I18n::Magic::Entity::Alphabet.new('ZH') }
    let(:ja_alphabet) { I18n::Magic::Entity::Alphabet.new('JA') }
    let(:tr_alphabet) { I18n::Magic::Entity::Alphabet.new('TR') }

    it 'should know the letters in the EN alphabet' do
      expect(en_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::EN_LETTERS)
    end

    it 'should know the letters in the AR alphabet' do
      expect(ar_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::AR_LETTERS)
    end

    it 'should know the letters in the RU alphabet' do
      expect(ru_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::RU_LETTERS)
    end

    it 'should know the letters in the DE alphabet' do
      expect(de_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::DE_LETTERS)
    end

    it 'should know the letters in the FR alphabet' do
      expect(fr_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::FR_LETTERS)
    end

    it 'should know the letters in the ES alphabet' do
      expect(es_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::ES_LETTERS)
    end

    it 'should know the letters in the HE alphabet' do
      expect(he_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::HE_LETTERS)
    end

    it 'should know the letters in the ZH alphabet' do
      expect(zh_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::ZH_LETTERS)
    end

    it 'should know the letters in the JA alphabet' do
      expect(ja_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::JA_LETTERS)
    end

    it 'should know the letters in the TR alphabet' do
      expect(tr_alphabet.letters).to match_array(I18n::Magic::Entity::Alphabet::TR_LETTERS)
    end
  end
end
