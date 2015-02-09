# puppet-percona
Install percona from binary tar.gz for Linux


download_url

 URL to download Percona-Server-*.Linux.x86_64.tar.gz from.
 
manage_user

 Create a user for the percona install.
 requires percona_group and percona_user defined.
install_dir

 /opt by default
 
symlink_name

 /opt/percona by default
 
version

 not evaluated automatically yet from download url (or vice-versa?)
 
initdb

 run mysql_install_db
 
manage_config_file

 creates a default config file for you, or custom config file of you define override_options.
 
manage_binaries_path

 creates a /etc/profile.d/percona.sh file adding binaries to PATH.
 
manage_directories

 ensure the creation of directories defined below. Parent dirs are created, but unmanaged by puppet.
 
manage_initd

 creates an initd file for you

List of files you can manage

  socketdir
  
  socket
  
  datadir
  
  logdir
  
  log_error
  
  piddir

  pidfile
  
  tmpdir
