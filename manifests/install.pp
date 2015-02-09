class percona::install {

    archive { "Percona-Server-${percona::version}.Linux.x86_64":
      ensure   => present,
      checksum => false,
      target   => $percona::install_dir,
      url      => $percona::download_url,
    }->

    file { "${percona::install_dir}/Percona-Server-${percona::version}.Linux.x86_64":
      recurse => true,
      owner => $percona::percona_user,
      group => $percona::percona_group,
      ensure => directory,
    }

    if $percona::symlink {
      file { "$percona::symlink_name":
        ensure  => link,
        require => Archive["Percona-Server-${percona::version}.Linux.x86_64"],
        target  => "${percona::install_dir}/Percona-Server-${percona::version}.Linux.x86_64",
        owner => $percona::percona_user,
        group => $percona::percona_group,
      }
    }

    if $percona::manage_binaries_path {
      file { '/etc/profile.d/percona.sh':
        mode    => 644,
        content => "PATH=\$PATH:$percona::symlink_name/bin",
      }
    }

    if $percona::manage_initd {
      file { '/etc/init.d/mysqld':
        content => template('percona/mysql.initd.erb'),
        mode     => '0755',
        owner    => root,
        group    => root,
        replace  => false,
      }
    }


}

