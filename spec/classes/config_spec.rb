require 'spec_helper'
describe 'gvpe::config' do

  it { should create_class('gvpe::config') }

  context 'with defaults for all parameters' do
    it { should contain_concat('/etc/gvpe/gvpe.conf') }
    it do should contain_concat__fragment('gvpe.conf.header').with(
      'target' => '/etc/gvpe/gvpe.conf',
      'order'  => '01',
    ) end
    it { should contain_file('/etc/gvpe/gvpe.conf') }
    it { should contain_file('/etc/gvpe/if-up') }
  end
end
