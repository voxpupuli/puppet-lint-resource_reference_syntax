Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-resource_reference_syntax'
  spec.version     = '2.0.0'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-resource_reference_syntax'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    '.rspec',
    'lib/**/*',
    'spec/**/*',
    'CHANGELOG.md',
  ]
  spec.summary     = 'puppet-lint reference_syntax check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure that the reference syntax follows Puppet 4 style
  EOF

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'puppet-lint', '>= 3', '< 5'
end
