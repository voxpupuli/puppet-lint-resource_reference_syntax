require 'spec_helper'

describe 'resource_reference_without_whitespace' do
  context 'a proper reference as array' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, notify => [ Title['one'], Title['two'] ]}" }

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference as array one fix, one variable' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, notify => [ Title['one'], Title[$two] ]}" }

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, notify => Title['one'],}" }

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a whitespace between reference and bracket' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, consume => Title ['one'],}" }

    it 'onlies detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'a whitespace between reference and bracket inside an array' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, consume => [ Title ['one'], Title['two']],}" }

    it 'onlies detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'stay within the parameter context' do
    let(:code) do
      "package { 'bar': ensure => installed,}  exec { 'baz': require => Package['bar'],} file { 'foo': ensure => file,}"
    end

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a whitespace between reference and bracket on chains' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "package { 'one': ensure => present, } Package ['one'] ~> Service ['two']" }

    it 'detects two problems' do
      expect(problems).to have(2).problem
    end

    it 'creates an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'more resources and a whitespace between reference and bracket on chains' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) do
      "package { 'one': ensure => present, } package { 'two': ensure => present, } Package ['one'] ~> Service['two']"
    end

    it 'detects one problem' do
      expect(problems).to have(2).problem
    end

    it 'creates an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'collectors should not cause an error' do
    let(:code) { "@package { 'bar': ensure => installed,}  Package <| |>" }

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end
end
