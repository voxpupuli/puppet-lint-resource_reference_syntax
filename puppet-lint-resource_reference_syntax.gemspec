Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-resource_reference_syntax'
  spec.version     = '3.0.0'
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

  spec.required_ruby_version = '>= 3.2'

  spec.add_dependency 'puppet-lint', '~> 5.1'
end
