# percona

[![Puppet Forge](http://img.shields.io/puppetforge/v/lesaux/percona.svg)](https://forge.puppetlabs.com/lesaux/percona)
[![Build Status](http://img.shields.io/travis/lesaux/puppet-percona.svg)](http://travis-ci.org/lesaux/puppet-percona)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with percona](#setup)
    * [What percona affects](#what-percona-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with percona](#beginning-with-percona)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs percona from binary tar.gz for Linux and perform basic configuration.

## Module Description

The module will download the binary archive from the percona website, and extract it for you.
It will additionally install a few library dependencies and create symlinks for the binaries to run.
Addtionally it can provide a default my.cnf configuration file, or customize one for you.
This is done in the same fashion as the puppetlabs-mysql module, since I am using their mysql-deepmerge library
to perform this task. A user can also be created which will be used to own files and run the process.

## Setup

### What percona affects

This module will download and extract the binary archive of percona to /opt/percona-server.X.X.X-linux-x64
It can optionally create a symlink such as /opt/percona as well.
The libaio1 and libaio-dev packages will also be installed, as well as the following library symlinks:
```
/usr/lib/libssl.so.6 -> /lib/x86_64-linux-gnu/libssl.so.1.0.0
/usr/lib/libcrypto.so.6 -> /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
```

### Beginning with percona

A simple example

```
class {'percona':
  percona_group        => mysql,
  percona_user         => mysql,
  symlink              => true,
  initdb               => false,
  manage_user          => true,
  manage_binaries_path => true,
  manage_config_file   => true,
  manage_directories   => true,
  manage_initd         => true,

  socketdir            => '/mysql/data',
  socket               => 'mysqld.sock',
  logdir               => '/mysql/logs',
  log_error            => 'mysql.err',
  piddir               => '/mysql/data',
  pidfile              => 'mysqld.pid',
  datadir              => '/mysql/data',
  tmpdir               => '/mysql/tmp',
}
```

The default my.cnf file would be:

```
[client]
port = 3306
socket = /mysql/data/mysqld.sock

[isamchk]
key_buffer_size = 16M

[mysqld]
bind-address = 127.0.0.1
datadir = /mysql/data
expire_logs_days = 10
key_buffer_size = 16M
log-error = /mysql/logs/mysql.err
max_allowed_packet = 16M
max_binlog_size = 100M
max_connections = 151
myisam_recover = BACKUP
pid-file = /mysql/data/mysqld.pid
port = 3306
query_cache_limit = 1M
query_cache_size = 16M
skip-external-locking
socket = /mysql/data/mysqld.sock
ssl = false
thread_cache_size = 8
thread_stack = 256K
tmpdir = /mysql/tmp
user = mysql

[mysqld_safe]
log-error = /mysql/logs/mysql.err
nice = 0
socket = /mysql/data/mysqld.sock

[mysqldump]
max_allowed_packet = 16M
quick
quote-names
```


## Usage

Check params.pp for defaults, and my.cnf defaults.

###Installation parameters

 [manage_user]

Create a user for the percona install. Requires percona_group, percona_gid, 
percona_user and percona_uid defined. Valid values are 'true' or 'false'. Defaults to false

 [install_dir]

/opt by default

 [symlink_name]

/opt/percona by default

 [version]

By default 5.5.41-rel37.0-727 is used.

 [initdb]

true or false: runs mysql_install_db. This code snippet was copied from puppetlabs-mysql module. Default is true.

 [manage_config_file]

creates a default config file, or a custom config file of you define an "override_options" array. Default is true.

 [manage_binaries_path]

creates a /etc/profile.d/percona.sh file adding binaries to PATH. Default is true.

 [manage_directories]

ensures the creation of directories defined below. Parent dirs are created, but unmanaged by puppet. Default is true.

 [manage_initd]

 creates an initd file for you. Default is true.

###Configuration parameters

####List of files and directories you can manage with parameters.
  $socketdir            = '/var/lib/mysql'
  $socket               = 'mysql.socket'
  $datadir              = '/var/lib/mysql'
  $logdir               = '/var/log/mysql'
  $log_error            = 'mysql-error.log'
  $piddir               = '/var/run/mysqld'
  $pidfile              = 'mysqld.pid'
  $tmpdir               = '/tmp'

  [socketdir]

defaults to /var/lib/mysql

  [socket]

defaults to mysql.socket

  [datadir]

defaults to /var/lib/mysql

  [logdir]

default to /var/log/mysql

  [log_error]

defaults mysql-error.log

  [piddir]

defaults to /var/run/mysqld

  [pidfile]

defaults to mysqld.pid

  [tmpdir]

defaults to /tmp

## Reference

Thanks to camptocamp for their awesome archives module.

## Limitations

At the moment the module works only on Ubuntu 14.04
