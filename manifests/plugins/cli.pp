class rabbitmq::plugins::cli($ensure = present) {
  $rabbitmqadmin = '/usr/sbin/rabbitmqadmin'
  $bash_completion = '/etc/bash_completion.d/rabbitmqadmin' 
  case $ensure {
    present: {
      $findservers = 'ls -1 /usr/lib/rabbitmq/lib/ | cut -f 2 -d -'
      $ezfilespec = '/usr/lib/rabbitmq/lib/rabbitmq_server-{}/plugins/rabbitmq_management-{}.ez'
      $clifilespec = 'rabbitmq_management-{}/priv/www/cli/rabbitmqadmin'
      if !defined(Package['unzip']) {
        package { 'unzip':
          ensure => present,
        }
      }
      exec { "create $rabbitmqadmin":
        creates => $rabbitmqadmin,
        cwd     => '/usr/sbin',
        path    => '/bin:/usr/bin',
        command => "${findservers} | xargs -i{} unzip -j ${ezfilespec} ${clifilespec}",
        require => [Package['unzip'], Package[$rabbitmq::package]],
      }
      exec { "create $bash_completion":
        creates => $bash_completion,
        command => "${rabbitmqadmin} --bash-completion > ${bash_completion}",
        require => Exec["create $rabbitmqadmin"],
      }
    }
    absent: {
      file { $path:
        ensure => absent,
      }
      file { $bash_completion:
        ensure => absent,
      }
    }
    default: {
      fail("ensure must be present or absent, not $ensure")
    }
  }
}
