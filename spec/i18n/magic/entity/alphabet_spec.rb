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
end
