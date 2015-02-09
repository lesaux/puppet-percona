class percona::config {

  file { '/etc/mysql':
    ensure  => directory,
    mode    => '0644',
  }

  $options = mysql_deepmerge($percona::default_options, $override_options)

  if $percona::manage_config_file {
    file { '/etc/mysql/my.cnf':
      content => template('percona/my.cnf.erb'),
      mode    => '0644',
    }
  }

}

