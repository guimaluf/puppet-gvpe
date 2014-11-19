# == Class: gvpe
#
# This module install configure gvpe service, generate nodes certificates and config files
#
# === Parameters
#
# Document parameters here.
# [*mtu*]
#   Sets the maximum MTU that should be used on outgoing packets
#   Default: 1500
# [*ifname*]
#   Sets the tun interface name to the given name.
#   Default: tun0
# [*loglevel*]
#   Set the logging level. Connection established messages are logged
#   at level *info*, notable errors are logged with *error*
#   Default: info
# [*udp_port*]
#   the udp port to use for sending/receiving packets
#   Default: 655
# [*tcp_port*]
#   the tcp port to listen for connections
#   Default: 655
# [*enable_udp*]
#   Enable the UDPv4 transport using the *udp_port* port
#   Default: false
# [*enable_tcp*]
#   Enable the TCPv4 transport using the *tcp_port* port
#   Default: false
# [*enable_rawip*]
#   Enable the RAW IPv4 transport using the ip_proto protocol
#   Default: true
# [*vpn_network*]
#   VPN network address. Node address are only set in the last octet.
#   Default: 192.168.1.0/24
#   Example: if *vpn_network* is 10.1.0.0/16, node ip address range is 10.1.0.0 --> 10.1.0.255
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'gvpe::config': }
#
# === Authors
#
# Guilherme Maluf Balzana <guimalufb@gmail.com>
#
# === Copyright
#
# Copyright 2014 Guilherme Maluf Balzana, <guimalufb@gmail.com>
#
class gvpe::config (
  $mtu          = $::gvpe::params::mtu,
  $ifname       = $::gvpe::params::ifname,
  $ifpersist    = $::gvpe::params::ifpersist,
  $loglevel     = $::gvpe::params::loglevel,
  $udp_port     = $::gvpe::params::udp_port,
  $tcp_port     = $::gvpe::params::tcp_port,
  $enable_udp   = $::gvpe::params::enable_udp,
  $enable_tcp   = $::gvpe::params::enable_tcp,
  $enable_rawip = $::gvpe::params::enable_rawip,
  $enable_icmp  = $::gvpe::params::enable_icmp,
  $vpn_network  = $::gvpe::params::vpn_network,
) inherits gvpe::params {

  concat { '/etc/gvpe/gvpe.conf':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment { 'gvpe.conf.header':
    target  => '/etc/gvpe/gvpe.conf',
    content => template('gvpe/gvpe.conf.erb'),
    order   => 01,
  }

  file { '/etc/gvpe/if-up':
    content => template('gvpe/if-up.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0774',
  }
}
