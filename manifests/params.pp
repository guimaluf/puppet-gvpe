# === Copyright
#
# Copyright 2014 Guilherme Maluf Balzana, <guimalufb@gmail.com>
#
class gvpe::params {
  case $::osfamily {
    'Debian': { # Debian/Ubuntu
      case $::lsbdistid {
        'Ubuntu': {
          $install_from_ppa = ($::lsbdistcodename == 'precise')
          $mtu              = 1500
          $ifname           = 'tun0'
          $log_level        = 'info'
          $udp_port         = 655
          $tcp_port         = 655
          $enable_udp       = false
          $enable_tcp       = false
          $enable_rawip     = true
          $vpn_network      = '10.0.0.0/8'
          $vpn_ip           = regsubst(
                                $::ipaddress,
                                '^([0-9]+)[.]([0-9]+)[.]([0-9]+)[.]([0-9]+)$',
                                '10.\2.\3.\4'
                              )
        }

        default: {
          fail("Not supported OS / Distribution: ${::osfamily}/${::lsbdistid}")
        }
      }
    }

    default: {
      fail("Not supported OS family ${::osfamily}")
    }
  }
}
