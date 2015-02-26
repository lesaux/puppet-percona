require 'spec_helper'
describe 'percona' do

  context 'with defaults for all parameters' do
    it { should contain_class('percona') }
  end

  context 'installs via archive and no symlink and no user and no initd' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '5.5.41-rel37.0-727',
        :manage_initd   => false,
      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('root') }
    it { should_not contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
  end

  context 'installs via archive and no symlink and user and no initd' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '5.5.41-rel37.0-727',
        :manage_initd   => false,
        :manage_user    => true,
        :percona_user   => 'percona',
        :percona_group  => 'percona',
        :percona_uid    => '999',
        :percona_gid    => '999',
      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_user('percona').with_uid('999').with_gid('999') }
    it { should contain_group('percona').with_gid('999') }
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('percona') }
    it { should_not contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
  end

  context 'installs via archive and no symlink and no user and initd' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '5.5.41-rel37.0-727',
        :manage_initd   => true,
      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('root') }
    it { should_not contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should contain_file('/etc/init.d/mysqld') }
  end

  context 'installs via archive and symlink and no user and no initd' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '5.5.41-rel37.0-727',
        :manage_initd   => false,
      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('root') }
    it { should contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
  end

  context 'installs via archive and symlink and user and no initd' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '5.5.41-rel37.0-727',
        :manage_initd   => false,
        :manage_user    => true,
        :percona_user   => 'percona',
        :percona_group  => 'percona',
        :percona_uid    => '999',
        :percona_gid    => '999',      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_user('percona').with_uid('999').with_gid('999') }
    it { should contain_group('percona').with_gid('999') }
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('percona') }
    it { should contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should_not contain_file('/etc/init.d/mysqld') }
  end

  context 'installs via archive and symlink and no user and initd' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '5.5.41-rel37.0-727',
        :manage_initd   => true,
      }
    end
    it { should contain_archive('Percona-Server')}
    it { should contain_file('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64').with_owner('root') }
    it { should contain_file('/opt/percona').with_ensure('link').with_target('/opt/Percona-Server-5.5.41-rel37.0-727.Linux.x86_64') }
    it { should contain_file('/etc/init.d/mysqld') }
  end

end


