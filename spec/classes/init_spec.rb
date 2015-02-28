require 'spec_helper'
describe 'percona' do

  context 'with defaults for all parameters' do
    it { should contain_class('percona') }
  end

  context 'installs via archive and no symlink and user and no initd' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end    
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '5.5.41-rel37.0-727',
        :manage_service => false,
        :manage_user    => true,
        :percona_user   => 'mysql',
        :percona_group  => 'mysql',
        :percona_uid    => '200',
        :percona_gid    => '200',
      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_user('mysql').with_uid('200').with_gid('200') }
    it { should contain_group('mysql').with_gid('200') }
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('mysql') }
    it { should_not contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[client]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.socket/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[isamchk]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^bind-address = 127.0.0.1/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^datadir = \/var\/lib\/mysqld/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^expire_logs_days = 10/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/var\/log\/mysqld\/mysqld.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_binlog_size = 100M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_connections = 151/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^myisam_recover = BACKUP/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^pid-file = \/var\/run\/mysqld\/mysqld.pid/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_limit = 1M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^skip-external-locking/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^ssl = false/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_cache_size = 8/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_stack = 256K/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^tmpdir = \/tmp/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^user = mysql/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld_safe]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/var\/log\/mysqld\/mysqld.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^nice = 0/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqldump]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quick/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quote-names/) }
  end

  context 'installs via archive and no symlink and user and no initd' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end    
    let :params do
      {
        :install_method   => 'archive',
        :symlink          => false,
        :version          => '5.5.41-rel37.0-727',
        :manage_service   => false,
        :manage_user      => true,
        :percona_user     => 'mysql',
        :percona_group    => 'mysql',
        :percona_uid      => '200',
        :percona_gid      => '200',
        :socketdir        => '/mysql/socket',
        :socket           => 'mysql.sock',
        :logdir           => '/mysql/logs',
        :log_error        => 'mysql.err',
        :piddir           => '/mysql/run',
        :pidfile          => 'mysql.pid',
        :datadir          => '/mysql/data',
        :tmpdir           => '/mysql/tmp',
        :override_options => {
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
            'sql_mode'        => 'ALLOW_INVALID_DATES',
            'sysdate-is-now'  => 1,
            'skip-name-resolve' => true,
            'skip-slave-start'  => true,
            'key_buffer_size' => '4G',
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
            'replicate-ignore-table' => 'commerce.tmpInv',
            'expire_logs_days' => '3',
            'log-bin'     => '/mysql/logs/mysql-bin',
            'binlog_format' => 'MIXED',
            'server-id'       => '111',
            'max_binlog_size'	=> '1GB',
            'relay-log' => '/mysql/logs/mysql-relay.log',
            'relay-log-index' => '/mysql/logs/mysql-relay-log.index',
            'relay-log-info-file' => '/mysql/logs/mysql-relay-log.info',
            'read_only' => '0',
            'skip-name-resolve' => true,
            'auto_increment_offset' => '1',
            'auto_increment_increment' => '2',
            'query_cache_limit'	=> '1M',
            'query_cache_type'        => '0',
            'query_cache_size' => '16M',
            'slow_query_log_file' => '/mysql/logs/mysql-slow.log',
            'slow_query_log'  => '1',
            'long_query_time' => '1',
            'log_queries_not_using_indexes' => true,
            'min_examined_row_limit' => '10000',
            'log_warnings' => '1',
            'innodb_data_home_dir' => '/mysql/data',
            'innodb_log_group_home_dir' => '/mysql/data',
            'innodb_data_file_path' => 'ibdata1:964M;ibdata2:2000M;ibdata3:2000M;ibdata4:2000M;ibdata5:2000M;ibdata6:20M:autoextend',
            'innodb_buffer_pool_size' => '20G',
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
      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_user('mysql').with_uid('200').with_gid('200') }
    it { should contain_group('mysql').with_gid('200') }
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('mysql') }
    it { should_not contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[client]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/mysql\/socket\/mysql.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[isamchk]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^bind-address = 0.0.0.0/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^datadir = \/mysql\/data/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^expire_logs_days = 3/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/mysql\/logs\/mysql.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_binlog_size = 1G/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_connections = 2000/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^myisam_recover = BACKUP/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^pid-file = \/mysql\/run\/mysql.pid/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_limit = 1M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^skip-external-locking/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/mysql\/socket\/mysql.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^ssl = false/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_cache_size = 100/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_stack = 256K/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^tmpdir = \/mysql\/tmp/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^user = mysql/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld_safe]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/mysql\/logs\/mysql.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^nice = -20/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/mysql\/socket\/mysql.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqldump]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quick/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quote-names/) }
  end

  context 'installs via archive and no symlink and user and no initd' do
    let :facts do
      {
        :osfamily => 'Redhat'
      }
    end    
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '5.5.41-rel37.0-727',
        :manage_service => false,
        :manage_user    => true,
        :percona_user   => 'mysql',
        :percona_group  => 'mysql',
        :percona_uid    => '200',
        :percona_gid    => '200',
      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_user('mysql').with_uid('200').with_gid('200') }
    it { should contain_group('mysql').with_gid('200') }
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('mysql') }
    it { should_not contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
    it { should contain_file('/etc/mysql/my.cnf') }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[client]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.socket/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[isamchk]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^bind-address = 127.0.0.1/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^datadir = \/var\/lib\/mysqld/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^expire_logs_days = 10/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/var\/log\/mysqld\/mysqld.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_binlog_size = 100M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_connections = 151/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^myisam_recover = BACKUP/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^pid-file = \/var\/run\/mysqld\/mysqld.pid/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_limit = 1M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^skip-external-locking/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^ssl = false/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_cache_size = 8/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_stack = 256K/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^tmpdir = \/tmp/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^user = mysql/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld_safe]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/var\/log\/mysqld\/mysqld.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^nice = 0/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqldump]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quick/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quote-names/) }
  end

  context 'installs via archive and symlink and user and no initd' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end    
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '5.5.41-rel37.0-727',
        :manage_service => false,
        :manage_user    => true,
        :percona_user   => 'mysql',
        :percona_group  => 'mysql',
        :percona_uid    => '200',
        :percona_gid    => '200',      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_user('mysql').with_uid('200').with_gid('200') }
    it { should contain_group('mysql').with_gid('200') }
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('mysql') }
    it { should contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
    it { should contain_file('/etc/mysql/my.cnf') }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[client]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.socket/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[isamchk]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^bind-address = 127.0.0.1/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^datadir = \/var\/lib\/mysqld/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^expire_logs_days = 10/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/var\/log\/mysqld\/mysqld.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_binlog_size = 100M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_connections = 151/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^myisam_recover = BACKUP/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^pid-file = \/var\/run\/mysqld\/mysqld.pid/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_limit = 1M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^skip-external-locking/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^ssl = false/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_cache_size = 8/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_stack = 256K/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^tmpdir = \/tmp/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^user = mysql/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld_safe]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/var\/log\/mysqld\/mysqld.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^nice = 0/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqldump]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quick/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quote-names/) }
  end

  context 'installs via archive and symlink and user and no initd' do
    let :facts do
      {
        :osfamily => 'Redhat'
      }
    end    
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '5.5.41-rel37.0-727',
        :manage_service => false,
        :manage_user    => true,
        :percona_user   => 'mysql',
        :percona_group  => 'mysql',
        :percona_uid    => '200',
        :percona_gid    => '200',      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_user('mysql').with_uid('200').with_gid('200') }
    it { should contain_group('mysql').with_gid('200') }
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('mysql') }
    it { should contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
    it { should contain_file('/etc/mysql/my.cnf') }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[client]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.socket/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[isamchk]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^bind-address = 127.0.0.1/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^datadir = \/var\/lib\/mysqld/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^expire_logs_days = 10/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^key_buffer_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/var\/log\/mysqld\/mysqld.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_binlog_size = 100M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_connections = 151/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^myisam_recover = BACKUP/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^pid-file = \/var\/run\/mysqld\/mysqld.pid/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^port = 3306/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_limit = 1M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^query_cache_size = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^skip-external-locking/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^ssl = false/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_cache_size = 8/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^thread_stack = 256K/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^tmpdir = \/tmp/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^user = mysql/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqld_safe]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^log-error = \/var\/log\/mysqld\/mysqld.err/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^nice = 0/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^socket = \/var\/lib\/mysqld\/mysqld.sock/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^[mysqldump]/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^max_allowed_packet = 16M/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quick/) }
    it { should contain_file('/etc/mysql/my.cnf').with_content(/^quote-names/) }
  end

end
