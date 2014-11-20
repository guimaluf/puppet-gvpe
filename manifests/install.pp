# == Class: gvpe::install
#
# This module install the gvpe package.
# PPA is configured cause gvpe is outdated on Precise repository
#
# === Copyright
#
# Copyright 2014 Guilherme Maluf Balzana, <guimalufb@gmail.com>
#
class gvpe::install inherits gvpe::params {

  if $::gvpe::params::install_from_ppa {
    include apt
    apt::ppa{ 'ppa:guimalufb/gvpe': }
    Apt::Ppa['ppa:guimalufb/gvpe'] -> Package['gvpe']
  }

  package { 'gvpe':
    ensure => latest,
  }

  file { '/etc/gvpe':
    ensure => directory,
    require => Package['gvpe'];
  }
}
