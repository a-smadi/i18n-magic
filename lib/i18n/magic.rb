require 'i18n/magic/version'
require 'optparse'

module I18n
  module Magic
    class CommandHandler
      def initialize(args)
        @opt_parser = OptionParser.new do |opt|
          opt.banner = 'Usage:'
          opt.separator '  i18n-magic [command] [options]'
          opt.separator ''

          opt.separator 'Options:'
          opt.on('-h', '--help', '# Show this help message and quit') do
            puts @opt_parser
            exit(true)
          end

          opt.separator ''

          opt.on('-v', '--version', '# Show i18n-magic version number and quit') do
            puts I18n::Magic::VERSION
            exit(true)
          end

          opt.separator ''
          opt.separator 'Commands:'
          opt.separator '  add                                # add a new translation'
          opt.separator '  server                             # start a mini server to handle missing translations form a web browser'
          opt.separator '  format                             # format all translation files for best usage results'
          opt.separator '  config                             # configure i18n-magic'
          opt.separator ''
        end

        begin
          @opt_parser.parse!
        rescue OptionParser::InvalidOption
          puts 'unknown option'
          exit(false)
        end

        handle(args)
      end

      private

      def handle(args)
        args[0] = nil if args.count.positive? && %w[initialize handle].include?(args[0])
        begin
          send(args[0])
        rescue TypeError
          puts @opt_parser
        rescue NoMethodError
          puts "unknown command: #{args[0]}"
        end
      end

      def add
        puts 'will add a new translation'
      end

      def server
        puts 'will start the server'
      end

      def format
        puts 'will format files'
      end

      def config
        puts 'will configure i18n-magic'
      end
    end
  end
end
