# === Copyright
#
# Copyright 2014 Guilherme Maluf Balzana, <guimalufb@gmail.com>
#
class gvpe::params {
  case $::osfamily {
    'Debian': { # Debian/Ubuntu
      case $::lsbdistid {
        'Ubuntu': {
          $install_from_ppa = ( $::lsbdistcodename == 'precise' )
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
