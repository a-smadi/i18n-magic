module I18n
  module Magic
    module Helpers
      class Environment
        LOCALE_FILES_PATH = 'config/locales/'.freeze
        LOCALE_FILES_SAMPLE_PATH = 'spec/sample/config/locales/'.freeze

        def self.locales(locale_files_path = LOCALE_FILES_PATH)
          locale_files = Dir["#{locale_files_path}*.yml"].select { |f| f =~ %r/\/[a-z]{2}.yml/ }
          locale_files.map { |f| f.remove(locale_files_path).remove('.yml').upcase }
        end
      end
    end
  end
end
