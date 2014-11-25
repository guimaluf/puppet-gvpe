# the default path for puppet to look for executables
Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

stage { 'pre': }

stage { 'pos': }

Stage['pre'] -> Stage['main'] -> Stage['pos']

class { 'puppetdb': }
class { 'puppetdb::master::config': }

include gvpe
gvpe::node {$::hostname:}
