require_relative '../helpers/string_ops'
require_relative 'translation_record'
require_relative 'alphabet'

module I18n
  module Magic
    module Entity
      class TranslationFile
        def initialize(locale, locale_files_path = I18n::Magic::Helpers::Environment::LOCALE_FILES_PATH)
          @locale   = locale
          @filename = "#{locale_files_path}#{locale.downcase}.yml"
        end

        def exists?
          File.file?(@filename)
        end

        def add(record)
          open(@filename, 'r+') do |file|
            if find("  #{record.key}:").positive?
              puts "this key already exists for :#{@locale}"
              break
            end
            position = find("# #{record.key.slice(0).upcase} #") + 1
            abort('translation file is not properly formatted !') unless position.positive?
            position.times { file.readline }
            prev = file.pos
            current_key = file.readline
            pos = file.pos
            while skip_this_line?(record.key, current_key.strip)
              prev = pos
              current_key = file.readline
              pos = file.pos
            end
            file.seek(prev)
            remainder = file.read
            file.seek(prev)
            file.write("#{record.as_string_row}\n" + remainder)
          end
        end

        def compatibility_score(text)
          locale_alphabet = I18n::Magic::Entity::Alphabet.new(@locale)
          locale_alphabet = learned_alphabet unless locale_alphabet.letters.any?
          locale_alphabet.belonging_score(text)
        end

        private

        def learned_alphabet
          locale_alphabet = I18n::Magic::Entity::Alphabet.new
          open(@filename, 'r+') do |file|
            %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z].each do |letter|
              file.seek(0)
              position = find("# #{letter} #") + 1
              abort('translation file is not properly formatted !') unless position.positive?
              position.times { file.readline }
              sample_text = file.readline
              next unless sample_text.present? && sample_text.include?(':')
              sample_text = sample_text[(sample_text.index(':') + 1)..-1].strip
              locale_alphabet.learn(sample_text)
            end
          end
          locale_alphabet
        end

        def find(keyword)
          count = 0
          File.open(@filename, 'r') do |file|
            file.each_line do |line|
              count += 1
              return count if line.match?(/#{keyword}/)
            end
          end
          -1
        end

        def skip_this_line?(key, current_key)
          return false if current_key.start_with?('#')
          key == [key, current_key.downcase].sort_by! { |text| text }.last
        end
      end
    end
  end
end
