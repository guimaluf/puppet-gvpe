require 'spec_helper'

describe 'gvpe::install' do

  it { should create_class('gvpe::install') }

  context 'with defaults for all parameters' do
    it { should contain_class('gvpe::params') }
    it { should contain_package('gvpe') }
    it { should contain_file('/etc/gvpe').with_ensure('directory') }
  end

  context 'on Ubuntu Precise' do
    let :facts do
      RSpec.configuration.default_facts.merge({
        :lsbdistrelease  => '12.04.5',
        :lsbdistcodename => 'precise',
      })
    end
    it { should contain_class('gvpe::params') }
    it { should contain_class('apt') }
    it { should contain_apt__ppa('ppa:guimalufb/gvpe').that_comes_before('Package[gvpe]') }
  end
end
