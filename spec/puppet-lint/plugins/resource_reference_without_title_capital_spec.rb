require 'spec_helper'

describe 'resource_reference_without_title_capital' do

  context 'a proper reference' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, notify => Title['one'],}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference in quotes' do
    let(:code) { "file { 'foo': ensure => file, notify => Title['One'],}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference as array in quotes' do
    let(:code) { "file { 'foo': ensure => file, notify => Title['one', 'two'],}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'multiple proper references as array in quotes' do
    let(:code) { "file { 'foo': ensure => file, notify => [ Title['one'], Title['two'] ],}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'multiple proper references as array one in quotes, one as variable' do
    let(:code) { "file { 'foo': ensure => file, notify => [ Title['one'], Title[$foo_var] ],}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference as variable' do
    let(:code) { "file { 'foo': ensure => file, notify => Title[$foo_var],}" }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference with a variable enclosed' do
    let(:code) {
      %(file {'foo': ensure => file, notify => Title["with ${param}"],} )
    }
    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'resource reference with title as capital letter' do
    let(:msg) { 'resource reference with title with capital letter' }
    let(:code) { "file { 'foo': ensure => file, notify => Title[One],}" }

    it 'should only detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'resource reference with title as array of capital letters' do
    let(:msg) { 'resource reference with title with capital letter' }
    let(:code) { "file { 'foo': ensure => file, notify => Title[One, Two],}" }

    it 'should only detect a single problem' do
      expect(problems)
    end

    it 'should create an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'resource reference with title as array of resource references with capital letters' do
    let(:msg) { 'resource reference with title with capital letter' }
    let(:code) { "file { 'foo': ensure => file, notify => [Title[One], Title[Two],]}" }

    it 'should only detect a single problem' do
      expect(problems)
    end

    it 'should create an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

  context 'resource reference with title without quotes' do
    let(:msg) { 'resource reference with title with capital letter' }
    let(:code) { "file { 'foo': ensure => file, notify => Title[one],}" }

    it 'should only detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'should create an error' do
      expect(problems).to contain_error(msg).on_line(1)
    end
  end

end
