require 'spec_helper'

describe 'resource_reference_with_unquoted_title' do
  let(:msg) { 'unquoted title in resource reference' }

  context 'with fix disabled' do
    context 'quoted resource ref on single line resource' do
      let(:code) { "file { 'foo': require => File['bar'] }" }

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'unquoted resource ref on single line resource' do
      let(:code) { "file { 'foo': require => File[bar] }" }

      it 'onlies detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'raises an error' do
        expect(problems).to contain_error(msg).on_line(1).in_column(31)
      end
    end

    context 'quoted resource ref on multi line resource' do
      let(:code) do
        <<-END
          file { 'foo':
            require => File['bar'],
          }
        END
      end

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'unquoted resource ref on multi line resource' do
      let(:code) do
        <<-END
          file { 'foo':
            require => File[bar]
          }
        END
      end

      it 'onlies detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'raises an error' do
        expect(problems).to contain_error(msg).on_line(2).in_column(29)
      end
    end

    context 'condensed resources with quoted refs' do
      let(:code) do
        <<-END
          file {
            'foo':
              require => File['bar'];
            'bar':
              require => File['baz'];
          }
        END
      end

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'condensed resources with an unquoted ref' do
      let(:code) do
        <<-END
          file {
            'foo':
              require => File[bar];
            'bar':
              require => File['baz'];
          }
        END
      end

      it 'onlies detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'raises an error' do
        expect(problems).to contain_error(msg).on_line(3).in_column(31)
      end
    end

    context 'resource refs with interpolated variables' do
      let(:code) do
        <<-END
          $file = 'bar'

          file { 'foo':
            require => File[$file]
          }
        END
      end

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context 'unquoted resource ref on single line resource' do
      let(:code) { "file { 'foo': require => File[bar] }" }

      it 'onlies detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'fixes the manifest' do
        expect(problems).to contain_fixed(msg).on_line(1).in_column(31)
      end

      it 'singles quote the resource title' do
        expect(manifest).to eq("file { 'foo': require => File['bar'] }")
      end
    end

    context 'unquoted resource ref on multi line resource' do
      let(:code) do
        <<-END
          file { 'foo':
            require => File[bar]
          }
        END
      end

      let(:fixed) do
        <<-END
          file { 'foo':
            require => File['bar']
          }
        END
      end

      it 'onlies detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'fixes the manifest' do
        expect(problems).to contain_fixed(msg).on_line(2).in_column(29)
      end

      it 'singles quote the resource ref' do
        expect(manifest).to eq(fixed)
      end
    end

    context 'condensed resources with an unquoted ref' do
      let(:code) do
        <<-END
          file {
            'foo':
              require => File[bar];
            'bar':
              require => File['baz'];
          }
        END
      end

      let(:fixed) do
        <<-END
          file {
            'foo':
              require => File['bar'];
            'bar':
              require => File['baz'];
          }
        END
      end

      it 'onlies detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'fixes the manifest' do
        expect(problems).to contain_fixed(msg).on_line(3).in_column(31)
      end

      it 'singles quote the resource title' do
        expect(manifest).to eq(fixed)
      end
    end
  end
end
