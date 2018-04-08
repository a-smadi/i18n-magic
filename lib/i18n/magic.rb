require 'active_support'
require 'active_support/core_ext'
require 'optparse'

require_relative 'magic/commands/add'
require_relative 'magic/version'

module I18n
  module Magic
    class CommandHandler
      UNDER_DEV_MSG = 'This feature is under development..'.freeze
      CMD_LIST = "\n" \
                 "Commands:\n" \
                 "  add                                # add a new translation\n" \
                 "  server                             # start a mini server to handle missing translations form a web browser\n" \
                 "  format                             # format all translation files for best usage results\n" \
                 "  config                             # configure i18n-magic\n" \
                 "\n".freeze

      def initialize(args)
        @args = args
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

          opt.separator CMD_LIST
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
        I18n::Magic::Commands::Add.new(key: @args[1], values: @args[2..-1], locale_files_path: I18n::Magic::Helpers::Environment::LOCALE_FILES_PATH).execute
      end

      def server
        puts UNDER_DEV_MSG
      end

      def format
        puts UNDER_DEV_MSG
      end

      def config
        puts UNDER_DEV_MSG
      end
    end
  end
end
