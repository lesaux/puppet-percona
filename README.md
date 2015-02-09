# puppet-percona
Install percona from binary tar.gz for Linux

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
    'skip-name-resolve' => true,
    'skip-slave-start'  => true,
    'key_buffer_size' => '512M',
    'myisam_data_pointer_size' => '6',
    'max_allowed_packet' => '32M',
    'table_open_cache' => '3000',
    'table_definition_cache' => '2000',
    'sort_buffer_size' => '8M',
    'read_buffer_size' => '8M',
    'myisam_sort_buffer_size' => '384M',
    'thread_cache_size' => '100',
    'max_connect_errors' => '1000',
    'max_connections' => '2000',
    'tmp_table_size' => '868M',
    'max_heap_table_size' => '868MB',
    'join_buffer_size' => '4M',
    'read_rnd_buffer_size' => '8M',
    'thread_concurrency' => '16',
    'log-slave-updates' => true,
    'expire_logs_days' => '3',
    'log-bin'     => '/mysql/logs/mysql-bin',
    'binlog_format' => 'MIXED',
    'server-id'       => $serverid,
    'max_binlog_size'	=> '1GB',
    'relay-log' => '/mysql/logs/mysql-relay.log',
    'relay-log-index' => '/mysql/logs/mysql-relay-log.index',
    'relay-log-info-file' => '/mysql/logs/mysql-relay-log.info',
    'read_only' => '0',
    'skip-name-resolve' => true,
    'auto_increment_offset' => '1',
    'auto_increment_increment' => '2',
    'query_cache_limit'	=> '1M',
    'query_cache_type'        => '1',
    'slow_query_log_file' => '/mysql/logs/mysql-slow.log',
    'slow_query_log'  => '1',
    'long_query_time' => '1',
    'log_queries_not_using_indexes' => true,
    'min_examined_row_limit' => '10000',
    'log_warnings' => '1',
    'innodb_data_home_dir' => '/mysql/data',
    'innodb_log_group_home_dir' => '/mysql/data',
    'innodb_buffer_pool_size' => '2G',
    'innodb_rollback_on_timeout' => '1',
    'innodb_log_files_in_group' => '2',
    'innodb_log_file_size' => '1024M',
    'innodb_log_buffer_size' => '10M',
    'innodb_flush_log_at_trx_commit' => '1',
    'innodb_file_per_table' => '1',
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
