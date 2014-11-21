require 'spec_helper'

describe 'gvpe::node', type: :define do
  let (:title) { 'test_node' }

  let :facts do
    RSpec.configuration.default_facts.merge({
      :ipaddress  => '10.0.0.1',
    })
  end

  it { should compile }
  it { should contain_class('gvpe::config') }
  it { should contain_file('/etc/gvpe/hostkey').with_require('Exec[generate rsa hostkey]') }
  it { should contain_exec('generate rsa hostkey') }
#  it do should contain_concat__fragment('test_node.node-conf')\
#               .with_target('/etc/gvpe/gvpe.conf')\
#               .with_content(/node = test_node/)\
#               .with_content(/hostname = 10.0.0.1/)\
#  end
#  it { should contain_file('/etc/gvpe/pubkeys/test_node') }
end
