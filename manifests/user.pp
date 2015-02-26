class percona::user {

  if $percona::manage_user {
    group { "$percona::percona_group":
      name                 => $percona::percona_group,
      ensure               => present,
      system               => true,
      gid                  => $percona::percona_gid,
    }
    user { "$percona::percona_user":
      name                 => $percona::percona_user,
      ensure               => present,
      comment              => "MySQL system account",
      gid                  => $percona::percona_gid,
      home                 => '/bin/false',
      managehome           => false,
      shell                => '/bin/false',
      system               => true,
      uid                  => $percona::percona_uid,
    }
  }

}
