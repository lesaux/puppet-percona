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

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What percona affects

This module will download and extract the binary archive of percona to /opt/
It can optionally create a symlink such as /opt/percona as well.
The module can create a default mysql configuration file, or customize it for you.
Mysql data folders can also be automatically created.

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

Create a user for the percona install.
requires percona_group, percona_gid, percona_user and percona_uid defined.

 [install_dir]

/opt by default

 [symlink_name]

/opt/percona by default

 [version]

By default 5.5.41-rel37.0-727 is used.

 [initdb]

run mysql_install_db. This code snippet was copied from puppetlabs-mysql module.

 [manage_config_file]

creates a default config file, or a custom config file of you define an "override_options" array.

 [manage_binaries_path]

creates a /etc/profile.d/percona.sh file adding binaries to PATH.

 [manage_directories]

ensures the creation of directories defined below. Parent dirs are created, but unmanaged by puppet.

 [manage_initd]

 creates an initd file for you

###Configuration parameters

####List of files and directories you can manage with parameters.

  [socketdir]

  [socket]

  [datadir]

  [logdir]

  [log_error]

  [piddir]

  [pidfile]

  [tmpdir]

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

At the moment the module works only on Ubuntu 14.04

