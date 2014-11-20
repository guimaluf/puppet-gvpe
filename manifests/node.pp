define gvpe::node (
  $rsa_key_size = 1280,
  $node         = $name,
  $hostname     = $::ipaddress,
) {
  include gvpe::config

  file { '/etc/gvpe/hostkey':
    require => Exec['generate rsa hostkey'],
    owner   => 'root',
    group   => 'root',
    mode    => '600',
  }

  exec { 'generate rsa hostkey':
    command  => "openssl genrsa -out /etc/gvpe/hostkey ${rsa_key_size}",
    cwd      => '/etc/gvpe/',
    creates  => '/etc/gvpe/hostkey',
    provider => 'shell',
  }

  file { "/etc/gvpe/pubkeys/${node}":
    require => Exec['generate rsa pubkey'],
  }

  exec { 'generate rsa pubkey':
    command  => "openssl rsa -in /etc/gvpe/hostkey -pubout -out /etc/gvpe/pubkeys/${node}",
    cwd      => '/etc/gvpe/pubkeys',
    creates  => "/etc/gvpe/pubkeys/${node}",
    provider => 'shell',
    require  => [File['/etc/gvpe/pubkeys'], File['/etc/gvpe/hostkey']],
  }

  concat::fragment { "${node}.node-conf":
    target  => '/etc/gvpe/gvpe.conf',
    content => template('gvpe/node-conf.erb'),
    order   => 99,
  }
}
