require 'spec_helper'

describe 'gvpe::node', type: :define do
  let (:title) { 'my_node' }

  let :facts do
    RSpec.configuration.default_facts.merge({
      :hostname   => 'test_node',
      :ipaddress  => '10.0.0.1',
    })
  end

  context 'with defaults for all parameters' do
    it { should compile }
    it { should contain_class('gvpe::config') }
    it { should contain_file('/etc/gvpe/hostkey').with_require('Exec[generate rsa hostkey]') }
    it { should contain_exec('generate rsa hostkey') }
    xit do should contain_concat__fragment('test_node.node-conf')\
                  .with_target('/etc/gvpe/gvpe.conf')\
                  .with_content(/node = test_node/)\
                  .with_content(/hostname = 10.0.0.1/)\
    end
    xit { should contain_file('/etc/gvpe/pubkey/test_node') }
    it { should contain_class('gvpe::service') }
  end
end
