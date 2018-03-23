module I18n
  module Magic
    module Helpers
      class Environment
        def self.locales
          locale_files = Dir['config/locales/*.yml'].select { |f| f =~ %r/\/[a-z]{2}.yml/ }
          locale_files.map { |f| f.remove('config/locales/').remove('.yml').upcase }
        end
      end
    end
  end
end
