class percona::service {

  if $percona::manage_service {

    file { '/etc/init.d/mysql':
      content => template('percona/mysql.initd.erb'),
      mode     => '0755',
      owner    => root,
      group    => root,
      replace  => false,
    }

    service { 'mysql':
      ensure     => $percona::ensure,
      enable     => $percona::enable,
      hasstatus  => true,
      hasrestart => true,
      require    => File['/etc/init.d/mysql']
    }    

  }

}
