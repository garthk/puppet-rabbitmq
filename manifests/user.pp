define rabbitmq::user($ensure = present, $password = undef, $user_tag = "") {
  $exists = "${rabbitmq::ctl} -q list_users | grep  '^${name}\t'"
  Exec { require => Package[$rabbitmq::package] }
  case $ensure {
    present: {
      if ! $password {
       fail("must specify password")
      }
      exec { "add_user ${name}":
       command => "${rabbitmq::ctl} add_user '${name}' '${password}'",
       unless  => $exists,
      }
      exec { "tag ${name}":
        command => "${rabbitmq::ctl} set_user_tags '${name}' '${user_tag}'",
        unless  => "${rabbitmq::ctl} -q list_users | grep  '^${name}\t\\[${user_tag}\\]'",
        require => Exec["add_user ${name}"],
      }
    }
    absent: {
      exec{ "delete_user ${name}":
       command => "${rabbitmq::ctl} delete_user '${name}'",
       onlyif  => $exists,
      }
    }
    default: {
      fatal("ensure must be present or absent, not ${ensure}")
    }
  }
}
