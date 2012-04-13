define rabbitmq::permissions($ensure = present, $vhost = "/", $conf = ".*", $read = ".*", $write = ".*") {
  require rabbitmq
  case $ensure {
    present: {
      exec { "set_permissions ${vhost} ${name}":
       command => "${rabbitmq::ctl} set_permissions -p '${vhost}' '${name}' '${conf}' '${write}' '${read}'",
        # flawed because grep picks up the regexp from the permission
       # unless  => "${rabbitmq::ctl} -q list_permissions -p '${vhost}' | grep '^${name}\t${conf}\t${write}\t${read}'",
      }
    }
    absent: {
      exec { "clear_permissions ${vhost} ${name}":
       command => "${rabbitmq::ctl} clear_permissions -p '${vhost}' '${name}'",
       onlyif  => "${rabbitmq::ctl} -q list_permissions -p '${vhost}' | grep '^${name}\t",
      }
    }
    default: {
      fatal("ensure must be present or absent, not ${ensure}")
    }
  }
}
