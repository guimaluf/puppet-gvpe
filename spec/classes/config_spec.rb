require 'spec_helper'
describe 'gvpe::config' do

  it { should create_class('gvpe::config') }

  context 'with defaults for all parameters' do
    it { should contain_file('/etc/gvpe/gvpe.conf')}
    it { should contain_concat('/etc/gvpe/gvpe.conf') }
    it do should contain_concat__fragment('gvpe.conf.header')\
                 .with_target('/etc/gvpe/gvpe.conf')\
                 .with_order('01')\
                 .with_content(/mtu = 1500/)\
                 .with_content(/ifname = tun0/)\
                 .with_content(/loglevel = info/)\
                 .with_content(/udp-port = 655/)\
                 .with_content(/tcp-port = 655/)\
                 .with_content(/enable-udp = false/)\
                 .with_content(/enable-tcp = false/)\
                 .with_content(/enable-rawip = true/)\
    end
    it { should contain_file('/etc/gvpe/if-up').with_content(/192.168.1.\$NODEID/) }
    it { should contain_file('/etc/gvpe/if-up').with_content(/192.168.1.0\/24/) }
    it { should contain_file('/etc/gvpe/pubkeys').with_ensure('directory') }
  end

  context 'with non-defaults parameters' do
    let :params do {
      :mtu          => '1492',
      :ifname       => 'vpe0',
      :loglevel     => 'error',
      :udp_port     => '6550',
      :tcp_port     => '6550',
      :enable_udp   => 'true',
      :enable_tcp   => 'true',
      :enable_rawip => 'false',
      :vpn_network  => '10.22.9.0/16',
    }end

    it do should contain_concat__fragment('gvpe.conf.header')\
                 .with_target('/etc/gvpe/gvpe.conf')\
                 .with_order('01')\
                 .with_content(/mtu = 1492/)\
                 .with_content(/ifname = vpe0/)\
                 .with_content(/loglevel = error/)\
                 .with_content(/udp-port = 6550/)\
                 .with_content(/tcp-port = 6550/)\
                 .with_content(/enable-udp = true/)\
                 .with_content(/enable-tcp = true/)\
                 .with_content(/enable-rawip = false/)\
    end
    it { should contain_file('/etc/gvpe/if-up').with_content(/10.22.9.\$NODEID/) }
    it { should contain_file('/etc/gvpe/if-up').with_content(/10.22.9.0\/16/) }
  end
end
