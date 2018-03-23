require_relative '../base_command'
require_relative '../entity/translation_file'
require_relative '../entity/translation_record'
require_relative '../helpers/environment'

module I18n::Magic::Commands
  class Add < I18n::Magic::BaseCommand
    def execute
      abort('missing key operand') unless @options[:key].present?

      if @options[:value1].nil?
        add_values_from_input
      else
        add_values_from_args
      end
    end

    private

    def add_values_from_input
      I18n::Magic::Helpers::Environment.locales.each do |locale|
        print "#{locale} for #{@options[:key]} (empty to add skip) : "
        value = STDIN.gets

        record = I18n::Magic::Entity::TranslationRecord.new(@options[:key], value)

        next unless record.valid?

        t_file = I18n::Magic::Entity::TranslationFile.new(I18n::Magic::Entity::TranslationFile.translation_filename(locale))

        abort('translation file does not exist !') unless t_file.exists?

        position = t_file.find("# #{record.key.slice(0).upcase} #") + 1

        abort('translation file is not properly formatted !') unless position.positive?

        t_file.add(record.as_row, position, record.key)
      end
    end

    def add_values_from_args
      [@options[:value1], @options[:value2]].each do |value|
        next unless value.present?

        record = I18n::Magic::Entity::TranslationRecord.new(@options[:key], value)

        abort('invalid key,value pair !') unless record.valid?

        t_file = I18n::Magic::Entity::TranslationFile.new(I18n::Magic::Entity::TranslationFile.suitable_t_file(record.value))

        abort('translation file does not exist !') unless t_file.exists?

        position = t_file.find("# #{record.key.slice(0).upcase} #") + 1

        abort('translation file is not properly formatted !') unless position.positive?

        t_file.add(record.as_row, position, record.key)
      end
    end
  end
end
