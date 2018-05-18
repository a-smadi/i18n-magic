require_relative '../base_command'
require_relative '../entity/translation_file'
require_relative '../entity/translation_record'
require_relative '../helpers/environment'
require_relative '../helpers/string_ops'

# TODO: enhance efficiency of learning alphabets from files (currently being learned from all files once per value)

module I18n
  module Magic
    module Commands
      class Add < I18n::Magic::BaseCommand
        def execute
          abort('missing key operand') unless @options[:key].present?
          if @options[:values].size.positive?
            add_values_from_args
          else
            add_values_from_input
          end
        end

        private

        def add_values_from_input
          I18n::Magic::Helpers::Environment.locales(@options[:locale_files_path]).each do |locale|
            print "#{locale} value for #{@options[:key]} (empty to skip) : "
            value = STDIN.gets
            record = I18n::Magic::Entity::TranslationRecord.new(@options[:key], value)
            next unless record.valid?
            translation_file = I18n::Magic::Entity::TranslationFile.new(locale, @options[:locale_files_path])
            abort('translation file does not exist !') unless translation_file.exists?
            translation_file.add(record)
          end
        end

        def add_values_from_args
          @options[:values].each do |value|
            next unless value.present?
            record = I18n::Magic::Entity::TranslationRecord.new(@options[:key], value)
            abort('invalid key,value pair !') unless record.valid?
            locale = I18n::Magic::Helpers::StringOps.locale(value, @options[:locale_files_path])
            translation_file = I18n::Magic::Entity::TranslationFile.new(locale, @options[:locale_files_path])
            abort('translation file does not exist !') unless translation_file.exists?
            translation_file.add(record)
          end
        end
      end
    end
  end
end
