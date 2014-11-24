# == Class: gvpe
#
# This module install configure gvpe service, generate nodes certificates and
# config files
#
#  class { 'gvpe': }
#
# === Authors
#
# Guilherme Maluf Balzana <guimalufb@gmail.com>
#
# === Copyright
#
# Copyright 2014 Guilherme Maluf Balzana, <guimalufb@gmail.com>
#
class gvpe {
  include gvpe::install
  gvpe::node {$::hostname:}
}
