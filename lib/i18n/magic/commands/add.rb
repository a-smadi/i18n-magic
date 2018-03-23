require_relative '../base_command'
require_relative '../entity/translation_file'
require_relative '../entity/translation_record'
require_relative '../helpers/environment'
require_relative '../helpers/string_ops'

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
        translation_file = I18n::Magic::Entity::TranslationFile.new(locale)
        abort('translation file does not exist !') unless translation_file.exists?
        translation_file.add(record)
      end
    end

    def add_values_from_args
      [@options[:value1], @options[:value2]].each do |value|
        next unless value.present?
        record = I18n::Magic::Entity::TranslationRecord.new(@options[:key], value)
        abort('invalid key,value pair !') unless record.valid?
        locale = I18n::Magic::Helpers::StringOps.locale(value)
        translation_file = I18n::Magic::Entity::TranslationFile.new(locale)
        abort('translation file does not exist !') unless translation_file.exists?
        translation_file.add(record)
      end
    end
  end
end
