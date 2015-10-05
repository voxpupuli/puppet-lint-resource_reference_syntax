require 'spec_helper'

describe 'resource_reference_without_title_capital' do

  context 'a proper reference' do
    let(:msg) { 'whitespce between reference type and title' }
    let(:code) { "file { 'foo': ensure => file, notify => Title['one'],}" }

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

end
