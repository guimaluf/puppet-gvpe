require 'spec_helper'

describe 'gvpe::install' do

  let :default_facts do {
    :osfamily           => 'Debian',
    :lsbdistid          => 'Ubuntu',
    :operatingsystem    => 'Ubuntu',
  }
  end

  it { should contain_class('gvpe::params') }
  it { should contain_package('gvpe') }
  it { should contain_file('/etc/gvpe').with_ensure('directory') }

  context 'on Ubuntu Precise' do
    let(:facts) do
      default_facts.merge({
        :lsbdistrelease  => '12.04.5',
        :lsbdistcodename => 'precise',
      })
    end
    it { should contain_class('gvpe::params') }
    it { should contain_class('apt::update') }
    it { should contain_apt__ppa('ppa:guimalufb/gvpe').that_comes_before('Package[gvpe]') }
  end
end
