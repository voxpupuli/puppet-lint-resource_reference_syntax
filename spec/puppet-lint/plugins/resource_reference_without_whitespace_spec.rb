require 'spec_helper'

describe 'resource_reference_without_whitespace' do

  context 'a proper reference as array' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, notify => [ Title['one'], Title['two'] ]}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference as array one fix, one variable' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, notify => [ Title['one'], Title[$two] ]}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, notify => Title['one'],}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a whitespace between reference and bracket' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, consume => Title ['one'],}" }

    it 'should only detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'a whitespace between reference and bracket inside an array' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, consume => [ Title ['one'], Title['two']],}" }

    it 'should only detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'stay within the parameter context' do
    let(:msg) { 'whitespace between reference type and title' }
    let(:code) { "package { 'bar': ensure => installed,}  exec { 'baz': require => Package['bar'],} File { 'foo': ensure => file,}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

end
