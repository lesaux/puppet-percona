# == Class: percona::prereqs
#
# None.
#
class percona::prereqs {

  ensure_packages ( [libaio1, libaio-dev] )

    file { '/usr/lib/libssl.so.6':
      ensure  => link,
      target  => '/lib/x86_64-linux-gnu/libssl.so.1.0.0',
    }

    file { '/usr/lib/libcrypto.so.6':
      ensure  => link,
      target  => '/lib/x86_64-linux-gnu/libcrypto.so.1.0.0',
    }

}
