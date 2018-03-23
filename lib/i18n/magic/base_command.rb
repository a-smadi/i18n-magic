module I18n::Magic
  class BaseCommand
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def execute
      raise NotImplementedError.new('Missing Implemnetation !')
    end
  end
end
