class percona::user {

  if $percona::manage_user {
    group { "$percona::percona_group":
      name                 => $percona::percona_group,
      ensure               => present,
      system               => true,
      gid                  => 200,
    }
    user { "$percona::percona_user":
      name                 => $percona::percona_user,
      ensure               => present,
      comment              => "MySQL system account",
      gid                  => 200,
      home                 => '/bin/false',
      managehome           => false,
      shell                => '/bin/false',
      system               => true,
      uid                  => 200,
    }
  }

}
