class percona::directories {

  if $percona::manage_directories {

    exec {'create_socketdir':
      command => "/bin/mkdir -p $percona::socketdir",
      unless  => "/usr/bin/test -d $percona::socketdir",
    }
    exec { 'chown_socketdir':
      command => "/bin/chown $percona::percona_user:$percona::percona_group $percona::socketdir",
      unless  => "/bin/sh -c '[ $(/usr/bin/stat -c %G $percona::socketdir) = $percona::percona_group ]'",
      require => Exec['create_socketdir'],
    }

    exec {'create_datadir':
      command => "/bin/mkdir -p $percona::datadir",
      unless  => "/usr/bin/test -d $percona::datadir",
    }
    exec { 'chown_datadir':
      command => "/bin/chown $percona::percona_user:$percona::percona_group $percona::datadir",
      unless  => "/bin/sh -c '[ $(/usr/bin/stat -c %G $percona::datadir) = $percona::percona_group ]'",
      require => Exec['create_datadir'],
    }

    exec {'create_logdir':
      command => "/bin/mkdir -p $percona::logdir",
      unless  => "/usr/bin/test -d $percona::logdir",
    }
    exec { 'chown_logdir':
      command => "/bin/chown $percona::percona_user:$percona::percona_group $percona::logdir",
      unless  => "/bin/sh -c '[ $(/usr/bin/stat -c %G $percona::logdir) = $percona::percona_group ]'",
      require => Exec['create_logdir'],
    }

    exec {'create_piddir':
      command => "/bin/mkdir -p $percona::piddir",
      unless  => "/usr/bin/test -d $percona::piddir",
    }
    exec { 'chown_piddir':
      command => "/bin/chown $percona::percona_user:$percona::percona_group $percona::piddir",
      unless  => "/bin/sh -c '[ $(/usr/bin/stat -c %G $percona::piddir) = $percona::percona_group ]'",
      require => Exec['create_piddir'],
    }

    exec {'create_tmpdir':
      command => "/bin/mkdir -p $percona::tmpdir",
      unless  => "/usr/bin/test -d $percona::tmpdir",
    }
    exec { 'chown_tmpdir':
      command => "/bin/chown $percona::percona_user:$percona::percona_group $percona::tmpdir",
      unless  => "/bin/sh -c '[ $(/usr/bin/stat -c %G $percona::tmpdir) = $percona::percona_group ]'",
      require => Exec['create_tmpdir'],
    }

  }

}
