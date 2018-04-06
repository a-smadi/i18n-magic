RSpec.describe I18n::Magic::Entity::TranslationRecord do
  let(:translation_record)         { I18n::Magic::Entity::TranslationRecord.new('HelloWorld', 'Hello World! My name is %{name}') }
  let(:invalid_translation_record) { I18n::Magic::Entity::TranslationRecord.new('HelloWorld', nil) }

  describe 'attribute readers' do
    it 'should provide read to :key' do
      expect(translation_record).to respond_to(:key)
    end

    it 'should provide read to :value' do
      expect(translation_record).to respond_to(:value)
    end
  end

  describe 'prepare key and value on initialize' do
    it 'should switch a CamelCase key to a snake_case one' do
      expect(translation_record.key).to eq('hello_world')
    end

    it 'should enclose the value with single quotes, if it includes a variable' do
      expect(translation_record.value).to eq("'Hello World! My name is %{name}'")
    end
  end

  describe '#valid?' do
    it 'should return false when key or value are nil' do
      expect(invalid_translation_record.valid?).to eq(false)
    end

    it 'should return true when key and value are present and have values' do
      expect(translation_record.valid?).to eq(true)
    end
  end

  describe '#as_string_row' do
    it 'should return a string containing the key and value in a formatted manner' do
      expect(translation_record.as_string_row).to eq("  #{translation_record.key}: #{translation_record.value}")
    end
  end
end
