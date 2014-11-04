# === Copyright
#
# Copyright 2014 Guilherme Maluf Balzana, <guimalufb@gmail.com>
#
class gvpe::params {
  $install_from_ppa = false

  case $::osfamily {
    'Debian': { # Debian/Ubuntu
      case $::lsbdistid {
        'Ubuntu': {
          $install_from_ppa = (versioncmp($::lsbdistrelease, '12.04') == 0)
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
