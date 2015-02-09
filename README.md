# puppet-percona
Install percona from binary tar.gz for Linux

Requires camptopcamp/archives

####Parameters

Check params.pp for defaults, and my.cnf defaults.

[download_url]

 URL to download Percona-Server-*.Linux.x86_64.tar.gz from.
 
[manage_user]

 Create a user for the percona install.
 requires percona_group and percona_user defined.

[install_dir]

 /opt by default
 
[symlink_name]

 /opt/percona by default
 
[version]

 not evaluated automatically yet from download url (or vice-versa?)
 
[initdb]

 run mysql_install_db
 
[manage_config_file]

 creates a default config file for you, or custom config file of you define override_options.
 
[manage_binaries_path]

 creates a /etc/profile.d/percona.sh file adding binaries to PATH.
 
[manage_directories]

 ensure the creation of directories defined below. Parent dirs are created, but unmanaged by puppet.
 
[manage_initd]

 creates an initd file for you

####Other parameters

List of files you can manage with parameters. You probably shouldn't have any of these in your override_options.

  [socketdir]
  
  [socket]
  
  [datadir]
  
  [logdir]
  
  [log_error]
  
  [piddir]

  [pidfile]
  
  [tmpdir]


####Example Usage:
```
#let's randomize server-id
$serverid = fqdn_rand(30)

$override_options = {
  'client' => {
    'port'             => '3306',
  },
  'mysqld_safe' => {
    'nice'		=> '-20',
  },
  'mysqld' => {
    'port'		=> '3306',
    'bind-address'      => '0.0.0.0',
    'skip-external-locking' => true,
    'old-passwords' => true,
  },
  'mysqldump' => {
    'quick' => 'true',
    'quote-names' => 'true',
    'max_allowed_packet' => '16M',
  },
  'isamchk' => {
    'key_buffer_size' => '16M',
  }
}

class {'percona':
  percona_group        => mysql,
  percona_user         => mysql,
  symlink              => true,
  initdb               => true,
  manage_user          => true,
  manage_binaries_path => true,
  manage_config_file   => true,
  manage_directories   => true,
  manage_initd         => true,

  socketdir            => '/mysql/socket',
  socket               => 'mysql.sock',
  logdir               => '/mysql/logs',
  log_error            => 'mysql.err',
  piddir               => '/mysql/pid',
  pidfile              => 'mysql.pid',
  datadir              => '/mysql/data',
  tmpdir               => '/mysql/tmp',

}
```
