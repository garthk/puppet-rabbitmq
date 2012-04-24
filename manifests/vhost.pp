define rabbitmq::vhost($ensure = present) {
  $exists = "${rabbitmq::ctl} list_permissions -p ${name}"
  Exec { require => Package[$rabbitmq::package] }
  case $ensure {
    present: {
      exec { "add_vhost ${name}":
         command => "${rabbitmq::ctl} add_vhost ${name}",
         unless  => $exists,
      }
    }
    absent: {
      exec { "delete_vhost ${name}":
         command => "${rabbitmq::ctl} delete_vhost ${name}",
         onlyif  => $exists,
      }
    }
    default: {
      fatal("ensure must be present or absent, not ${ensure}")
    }
  }
}
