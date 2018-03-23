require_relative '../helpers/string_ops'
require_relative 'translation_record'

module I18n::Magic::Entity
  class TranslationFile
    def initialize(locale)
      @filename = "config/locales/#{locale.downcase}.yml"
    end

    def exists?
      File.file?(@filename)
    end

    def add(record)
      open(@filename, 'r+') do |file|
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
      0
    end

    private

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
