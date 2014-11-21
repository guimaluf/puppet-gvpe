require 'spec_helper'

describe 'gvpe::service' do
  let :facts do
    RSpec.configuration.default_facts.merge({
      :hostname   => 'test_node',
    })
  end

 it { should create_class('gvpe::service') }
 it do should contain_service('gvpe')\
             .with_ensure('running')\
             .with_enable('true')\
             .with_binary('/usr/sbin/gvpe -L test_node')\
             .with_provider('base')\
 end
 it { should contain_exec('retry connect to all nodes').with_command('/usr/bin/gvpectrl -kHUP') }
end
