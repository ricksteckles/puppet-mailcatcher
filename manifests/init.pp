class mailcatcher {
  package { 'sqlite3':
    ensure => present
  }

  package { 'libsqlite3-dev':
    ensure => present
  }

  package { 'mailcatcher':
    provider => gem,
    ensure => present,
    require => Package['sqlite3', 'libsqlite3-dev']
  }

  file { '/etc/init/mailcatcher.conf':
    content => template('mailcatcher/upstart.conf.erb'),
    alias => 'mailcatcher.conf'
  }

  service { 'mailcatcher':
    ensure   => running,
    provider => upstart,
    hasstatus => true,
    require => [ File['mailcatcher.conf'], Package['mailcatcher'] ]
  }
}
