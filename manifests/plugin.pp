define rabbitmq::plugin($enable = true) {
  Exec { require => Package[$rabbitmq::package] }
  case $enable {
    true: {
      exec { "enable plugin ${name}":
        command => "${rabbitmq::plugins} enable ${name}",
        notify  => Service[$rabbitmq::service],
        # want capital E for enable => true
        unless  => "${rabbitmq::plugins} list ${name} | grep '^\\[E\\] ${name} '",
      }
    }
    false: {
      exec { "disable plugin ${name}":
        command => "${rabbitmq::plugins} disable ${name}",
        notify  => Service[$rabbitmq::service],
        # need capital or lower case E before disabling
        onlyif  => "${rabbitmq::plugins} list ${name} | grep '^\\[[Ee]\\] ${name} '",
      }
    }
    default: {
      fatal("enable must be true or false, not ${enable}")
    }
  }
}
