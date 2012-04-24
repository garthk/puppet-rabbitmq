define rabbitmq::permissions($ensure = present, $vhost = "/", $conf = ".*", $read = ".*", $write = ".*", $user = $name) {
  Exec { require => Package[$rabbitmq::package] }
  case $ensure {
    present: {
      $exec_title = "set_permissions ${vhost} ${user}"
      exec { $exec_title:
       command => "${rabbitmq::ctl} set_permissions -p '${vhost}' '${user}' '${conf}' '${write}' '${read}'",
       # flawed because grep picks up the regexp from the permission
       # unless  => "${rabbitmq::ctl} -q list_permissions -p '${vhost}' | grep '^${user}\t${conf}\t${write}\t${read}'",
        require => [Rabbitmq::User[$user], Rabbitmq::Vhost[$vhost]],
      }
    }
    absent: {
      exec { "clear_permissions ${vhost} ${user}":
       command => "${rabbitmq::ctl} clear_permissions -p '${vhost}' '${user}'",
       onlyif  => "${rabbitmq::ctl} -q list_permissions -p '${vhost}' | grep '^${user}\t",
      }
    }
    default: {
      fatal("ensure must be present or absent, not ${ensure}")
    }
  }
}
