module I18n
  module Magic
    module Helpers
      class Environment
        def self.locales(dir_path = 'config/locales/')
          locale_files = Dir["#{dir_path}*.yml"].select { |f| f =~ %r/\/[a-z]{2}.yml/ }
          locale_files.map { |f| f.remove(dir_path).remove('.yml').upcase }
        end
      end
    end
  end
end
