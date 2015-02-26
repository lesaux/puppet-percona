class percona (

  $percona_group        = $percona::params::percona_group,
  $percona_gid          = $percona::params::percona_gid,
  $percona_user         = $percona::params::percona_user,
  $percona_uid          = $percona::params::percona_uid,
  $install_dir          = $percona::params::install_dir,
  $install_method       = $percona::params::install_method,
  $symlink              = $percona::params::symlink,
  $symlink_name         = "${install_dir}/percona",
  $version              = $percona::params::version,
  $initdb               = $percona::params::initdb,
  $manage_user          = $percona::params::manage_user,
  $manage_config_file   = $percona::params::manage_config_file,
  $manage_binaries_path = $percona::params::manage_binaries_path,
  $manage_directories   = $percona::params::manage_directories,
  $manage_initd         = $percona::params::manage_initd,
  
  $socketdir            = $percona::params::socketdir,
  $socket               = $percona::params::socket,
  $datadir              = $percona::params::datadir,
  $logdir               = $percona::params::logdir,
  $log_error            = $percona::params::log_error,
  $piddir               = $percona::params::piddir,
  $pidfile              = $percona::params::pidfile,
  $tmpdir               = $percona::params::tmpdir,

  $default_options = {
    'client'                  => {
      'port'                  => '3306',
      'socket'                => "$socketdir/$socket",
    },
    'mysqld_safe'             => {
      'nice'                  => '0',
      'log-error'             => "$logdir/$log_error",
      'socket'                => "$socketdir/$socket",
    },
    'mysqld'                  => {
      'basedir'               => $symlink_name,
      'bind-address'          => '127.0.0.1',
      'datadir'               => $datadir,
      'expire_logs_days'      => '10',
      'key_buffer_size'       => '16M',
      'log-error'             => "$logdir/$log_error",
      'max_allowed_packet'    => '16M',
      'max_binlog_size'       => '100M',
      'max_connections'       => '151',
      'myisam_recover'        => 'BACKUP',
      'pid-file'              => "$piddir/$pidfile",
      'port'                  => '3306',
      'query_cache_limit'     => '1M',
      'query_cache_size'      => '16M',
      'skip-external-locking' => true,
      'socket'                => "$socketdir/$socket",
      'ssl'                   => false,
      'ssl-ca'                => $ssl_ca,
      'ssl-cert'              => $ssl_cert,
      'ssl-key'               => $ssl_key,
      'ssl-disable'           => false,
      'thread_cache_size'     => '8',
      'thread_stack'          => '256K',
      'tmpdir'                => $tmpdir,
      'user'                  => $percona_user,
    },
    'mysqldump'             => {
      'max_allowed_packet'  => '16M',
      'quick'               => true,
      'quote-names'         => true,
    },
    'isamchk'      => {
      'key_buffer_size' => '16M',
    },
  }

) inherits percona::params {
    
    class {'percona::user': }->
    class {'percona::prereqs': }->
    class {'percona::archive': }->
    class {'percona::config': }->
    class {'percona::directories': }->
    class {'percona::initdb': }
  
}
