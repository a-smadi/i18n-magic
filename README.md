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

Currently theres only a single command available; `add` which automatically adds the translation record alphabetically ordered into the file it reckons suitable.

The `add` command may be used in 2 different ways:

1- Adding translations as input after running the command. (useful when adding translations with special characters)

```
i18n-magic add hello_world
```
and the user will be prompted to enter translations for that key after running the command.

PS: The key can be in snake_case or CamelCase.

```
i18n-magic add hello_world
```
and
```
i18n-magic add HelloWorld
```
are both acceptable.


2- Adding multiple translation values using a single command. (experimental feature / may be faulty for projects handling locales with somewhat similar alphabets)

```
i18n-magic add hello_world "Hello, World!" "مرحبا"
```
PS: precednece of values doesn't have any effect. As long as the key comes first, i18n-magic will automatically recognise the translation value locales, so
```
i18n-magic add hello_world "مرحبا" "Hello, World!"
```
is also acceptable.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
