require 'spec_helper'

describe 'gvpe' do

  it { should create_class('gvpe') }

  context 'with defaults for all parameters' do
    it { should contain_class('gvpe::install')}
    it { should contain_class('gvpe::config') }
  end
end
