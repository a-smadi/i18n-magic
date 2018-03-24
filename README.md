# I18n::Magic

[![Maintainability](https://api.codeclimate.com/v1/badges/479e81db41acc3f00d92/maintainability)](https://codeclimate.com/github/a-smadi/i18n-magic/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/479e81db41acc3f00d92/test_coverage)](https://codeclimate.com/github/a-smadi/i18n-magic/test_coverage)
[![Build Status](https://travis-ci.org/a-smadi/i18n-magic.svg?branch=master)](https://travis-ci.org/a-smadi/i18n-magic)

Easy localization management for Ruby projects that are using the i18n gem.

## Features

* add translation key and values from the command line
* add missing translations using a HTTP web form
* format existing localization files

## Installation

```ruby
gem 'i18n-magic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-magic

## Tests

You can run tests using `rake` or `rake spec`

## Usage

Currently theres only a single command available; `add` which automatically adds the translation record to the file it reckons suitable, depending on the language detected in the provided value.

The command accepts a `key` argument, and a unlimited number of values for the desired translations to be added.

PS: The key can be in snake_case or CamelCase.

```
i18n-magic add hello_world "Hello, World!"
```
and
```
i18n-magic add HelloWorld "Hello, World!"
```
are both acceptable.


Also, adding multiple translation values for the same key at once is possible, as such:

```
i18n-magic add hello_world "Hello, World!" "مرحبا"
```
PS: precednece of values doesn't have any effect, as long as the key comes first, so
```
i18n-magic add hello_world "مرحبا" "Hello, World!"
```
is also acceptable.

In addition, adding translations as input after running the command is possible as follows: (especially useful when adding translations with special characters)

```
i18n-magic add hello_world
```
and the user will be prompted to enter translations for that key after running the command.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
