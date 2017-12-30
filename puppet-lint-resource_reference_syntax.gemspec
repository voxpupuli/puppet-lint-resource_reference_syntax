Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-resource_reference_syntax'
  spec.version     = '1.0.11'
  spec.homepage    = 'https://github.com/tuxmea/puppet-lint-resource_reference_syntax'
  spec.license     = 'APL2'
  spec.author      = 'Martin Alfke'
  spec.email       = 'ma@example42.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    '.rspec',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'puppet-lint reference_syntax check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure that the reference syntax follows Puppet 4 style
  EOF

  spec.add_dependency             'puppet-lint', '>= 1.0', '< 3.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'simplecov', '~> 0'
end
