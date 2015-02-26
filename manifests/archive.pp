class percona::archive {

  if $percona::install_method == archive {

    #Some regexp mojo to build the url from version.
    #remove chars after dash in version i.e 5.5.41-rel37.0
    $stripped_version     = regsubst( $percona::version, '\-[^.]*$', '' )
    #remove "rel" from previous regsubst result i.e 5.5.41-37.0
    $short_version        = regsubst( $stripped_version, 'rel', '' , 'G')
    #keep first two values separated by dot i.e 5.5
    $major_version        =regsubst( $percona::version, '^([^.]*.[^.]*).*$', '\1'  )

    $download_url         = "http://www.percona.com/downloads/Percona-Server-${major_version}/Percona-Server-${short_version}/binary/tarball/Percona-Server-${version}.Linux.x86_64.tar.gz"



    archive { "Percona-Server":
      name     => "Percona-Server-${percona::version}.Linux.x86_64",
      ensure   => present,
      checksum => false,
      target   => $percona::install_dir,
      url      => $download_url,
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

}

