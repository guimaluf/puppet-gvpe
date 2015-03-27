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
    start    => "/usr/sbin/gvpe -L ${::hostname}",
    stop     => '/usr/bin/gvpectrl -kKILL',
    status   => '/usr/bin/pgrep gvpe',
    require  => Class['gvpe::install'],
  }
}
