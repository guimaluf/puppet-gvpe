# == Class: gvpe::service
#
# This module run gvpe service
#
# === Authors
#
# Guilherme Maluf Balzana <guimalufb@gmail.com>
#
# === Copyright
#
# Copyright 2014 Guilherme Maluf Balzana, <guimalufb@gmail.com>
#
class gvpe::service inherits gvpe::params {
  service {'gvpe':
    ensure  => running,
    enable  => true,
    binary  => "/usr/sbin/gvpe -L $::hostname",
  }

  exec {'retry connect to all nodes':
    command     => '/usr/bin/gvpectrl -kHUP',
    provider    => 'shell',
    refreshonly => true,
  }

}
