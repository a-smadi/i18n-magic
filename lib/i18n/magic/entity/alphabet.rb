require_relative '../helpers/string_ops'

module I18n::Magic::Entity
  class Alphabet
    def initialize
      @letters = %w[]
    end

    def learn(sample_text)
      return unless sample_text.present? && sample_text.size.positive?
      normalized_text = I18n::Magic::Helpers::StringOps.letters_only(sample_text).downcase
      normalized_text.chars.each { |character| @letters.push(character) unless @letters.include?(character) }
    end

    def belonging_score(text)
      score = 0
      normalized_text = I18n::Magic::Helpers::StringOps.letters_only(text).downcase
      return 0 unless normalized_text.present? && normalized_text.size.positive?
      normalized_text.chars.each { |character| score += (100.0 / normalized_text.size) if @letters.include?(character) }
      score.to_i
    end
  end
end
