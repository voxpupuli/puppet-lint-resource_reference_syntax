# puppet-lint plugin resource reference check

**Note, this plugin will check for Puppet resource reference syntax which will no 
longer work with Puppet 4.x.**

## Installation

To use this plugin, add the following like to the Gemfile in your Puppet code
base and run `bundle install`.

```ruby
gem 'puppet-lint-resource_reference_syntax'
```

## Usage

This plugin provides two new checks to `puppet-lint`.

### resource_reference_without_whitespace

**--fix support: No**

This check will raise an error for any resource reference that has a whitespace
between the Type reference and the opening bracket.

```
ERROR: whitespce between reference type and title on line 4
```

### resource_reference_without_title_capital

**--fix support: No**

This check will raise an error for any resource reference that uses the title with capital letter.

```
ERROR: resource reference with title with capital letter on line 4
```

