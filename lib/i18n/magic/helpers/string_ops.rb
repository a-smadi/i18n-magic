require_relative 'environment'

module I18n::Magic::Helpers
  class StringOps
    def self.underscore(text)
      text.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
    end

    def self.locale(text)
      locales = I18n::Magic::Helpers::Environment.locales
      text_locale = locales[0]
      score = 0
      locales.each do |locale|
        locale_score = I18n::Magic::Entity::TranslationFile.new(locale).compatibility_score(text)
        if locale_score > score
          text_locale = locale
          score = locale_score
        end
      end
      text_locale
    end
  end
end
