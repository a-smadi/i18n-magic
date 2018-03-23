
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "i18n/magic/version"

Gem::Specification.new do |spec|
  spec.name          = "i18n-magic"
  spec.version       = I18n::Magic::VERSION
  spec.authors       = ["Ali Smadi"]
  spec.email         = ["alielsmadi@gmail.com"]

  spec.summary       = %q{a gem to better manage i18n translation files.}
  spec.description   = %q{easy localization management for Ruby projects that are using the i18n gem.}
  spec.homepage      = "https://github.com/a-smadi/i18n-magic"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = 'i18n-magic'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-rubocop"

  spec.add_dependency "activesupport"
end
