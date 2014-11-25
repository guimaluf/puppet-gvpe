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
class gvpe::service {

  service { 'gvpe':
    ensure   => running,
    enable   => true,
    provider => 'base',
    binary   => "/usr/sbin/gvpe -L ${::hostname}",
    require  => Class['gvpe::install'],
  }

  exec { 'retry connect to all nodes':
    command     => '/usr/bin/gvpectrl -kHUP',
    provider    => 'shell',
    refreshonly => true,
  }

}
