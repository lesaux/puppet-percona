# == Class: percona::params
#
# Default parameters
#
class percona::params {

#installation variables

  $percona_group        = 'mysql'
  $percona_gid          = '200'
  $percona_user         = 'mysql'
  $percona_uid          = '200'
  $install_dir          = '/opt'
  $install_method       = 'archive'
  $symlink              = true
  $version              = '5.5.41-rel37.0-727'
  $binary_dir           = '/usr/bin'
  $initdb               = true
  $manage_user          = true
  $manage_config_file   = true
  $manage_binaries_path = true
  $manage_directories   = true
  $manage_service       = true
  $ensure               = true
  $enable               = true

#my.cnf config variables

  $socketdir            = '/var/lib/mysqld'
  $socket               = 'mysqld.socket'
  $datadir              = '/var/lib/mysqld'
  $logdir               = '/var/log/mysqld'
  $log_error            = 'mysqld.err'
  $piddir               = '/var/run/mysqld'
  $pidfile              = 'mysqld.pid'
  $tmpdir               = '/tmp'

}

