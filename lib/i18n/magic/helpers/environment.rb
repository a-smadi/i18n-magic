module I18n
  module Magic
    module Helpers
      class Environment
        LOCALE_FILES_PATH = 'config/locales/'.freeze
        LOCALE_FILES_SAMPLE_PATH = 'spec/sample/config/locales/'.freeze

        def self.locales(dir_path = LOCALE_FILES_PATH)
          locale_files = Dir["#{dir_path}*.yml"].select { |f| f =~ %r/\/[a-z]{2}.yml/ }
          locale_files.map { |f| f.remove(dir_path).remove('.yml').upcase }
        end
      end
    end
  end
end
