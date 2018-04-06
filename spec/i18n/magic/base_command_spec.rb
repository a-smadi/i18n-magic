RSpec.describe I18n::Magic::BaseCommand do
  let(:base_command) { I18n::Magic::BaseCommand.new }

  describe 'attribute readers' do
    it 'should provide read to :letters' do
      expect(base_command).to respond_to(:options)
    end
  end

  describe '#execute' do
    it 'should raise an error, since this method should be overridden by inheriting commands' do
      expect { base_command.execute }.to raise_error('Missing Implemnetation !')
    end
  end
end
