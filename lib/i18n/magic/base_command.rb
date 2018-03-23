module I18n
  module Magic
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
end
