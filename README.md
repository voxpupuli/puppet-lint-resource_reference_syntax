# puppet-lint plugin resource reference check

[![License](https://img.shields.io/github/license/voxpupuli/puppet-lint-resource_reference_syntax.svg)](https://github.com/voxpupuli/puppet-lint-resource_reference_syntax/blob/master/LICENSE)
[![Test](https://github.com/voxpupuli/puppet-lint-resource_reference_syntax/actions/workflows/test.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-resource_reference_syntax/actions/workflows/test.yml)
[![Release](https://github.com/voxpupuli/puppet-lint-resource_reference_syntax/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-resource_reference_syntax/actions/workflows/release.yml)
[![RubyGem Version](https://img.shields.io/gem/v/puppet-lint-resource_reference_syntax.svg)](https://rubygems.org/gems/puppet-lint-resource_reference_syntax)
[![RubyGem Downloads](https://img.shields.io/gem/dt/puppet-lint-resource_reference_syntax.svg)](https://rubygems.org/gems/puppet-lint-resource_reference_syntax)
[![Donated by example42](https://img.shields.io/badge/donated%20by-example42-fb7047.svg)](#transfer-notice)

**Note, this plugin will check for Puppet resource reference syntax which will no longer work with Puppet 4.x.**

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

e.g. the following code is NOT good for Puppet 4:

```
  require => File ['/etc/motd']
```
and will result in the following error:

```
ERROR: whitespce between reference type and title on line 4
```

### resource_reference_without_title_capital

**--fix support: No**

This check will raise an error for any resource reference that uses the title with capital letter without enclosed quotes.

e.g. the following code will not work on Puppet 4:
```
  require => Service[Apache],
  require => Service[Apache, Mysql],
  require => Service[apache]
```
and will result in the following error:
```
ERROR: resource reference with title with capital letter on line 4
```

The following references are good code for Puppet 4:

```
  require => Service['apache'],
  require => Service['apache', 'mysql'],
  require => [ Service['apache'], Service['mysql'] ],
```

## Transfer Notice

This plugin was originally authored by [example42](https://example42.de).
The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of Camptocamp.

## License

This gem is licensed under the Apache-2 license.

## Release information

To make a new release, please do:
* update the version in the gemspec file
* Install gems with `bundle install --with release --path .vendor`
* generate the changelog with `bundle exec rake changelog`
* Check if the new version matches the closed issues/PRs in the changelog
* Create a PR with it
* After it got merged, push a tag. GitHub actions will do the actual release to rubygems and GitHub Packages
