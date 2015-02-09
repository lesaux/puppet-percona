# == Class: percona::params
#
# Default parameters
#
class percona::params {

#installation variables

  $percona_group        = 'root'
  $percona_user         = 'root'
  $install_dir          = '/opt'
  $install_method       = 'archive'
  $symlink              = false
  $version              = '5.5.41-rel37.0-727'
  $binary_dir           = '/usr/bin'
  $initdb               = false
  $manage_user          = false
  $manage_config_file   = false
  $manage_binaries_path = false
  $manage_directories   = false
  $manage_initd         = false

#my.cnf config varibles

  $socketdir            = '/var/lib/mysql'
  $socket               = 'mysql.socket'
  $datadir              = '/var/lib/mysql'
  $logdir               = '/var/log/mysql'
  $log_error            = 'mysql-error.log'
  $piddir               = '/var/run/mysqld'
  $pidfile              = 'mysqld.pid'
  $tmpdir               = '/tmp'

   
}

