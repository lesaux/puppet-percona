class percona::initdb {

   if $percona::initdb {

     if $percona::manage_config_file {
       $install_db_args = "--basedir=${percona::symlink_name} --defaults-extra-file=/etc/mysql/my.cnf --datadir=${percona::datadir} --user=${percona::percona_user}"
     } else {
       $install_db_args = "--basedir=${percona::symlink_name} --datadir=${percona::datadir} --user=${percona::percona_user}"
     }

     exec { 'mysql_install_db':
       command   => "mysql_install_db ${install_db_args}",
       creates   => "${percona::datadir}/mysql",
       logoutput => on_failure,
       path      => "/bin:/sbin:/usr/bin:/usr/sbin:$percona::symlink_name/bin:$percona::symlink_name/scripts",
       require   => Archive["Percona-Server-${percona::version}.Linux.x86_64"],
     }

   }

}
