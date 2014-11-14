require 'spec_helper'
describe 'gvpe' do

  context 'with defaults for all parameters' do
    it { should contain_class('gvpe') }
    it { should contain_class('gvpe::install') }
  end
end
