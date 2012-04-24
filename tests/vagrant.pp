stage { pre: before => Stage[main] }

class apt_get_update {
  $sentinel = "/var/lib/apt/first-puppet-run"

  exec { "initial apt-get update":
    command => "/usr/bin/apt-get update && touch ${sentinel}",
    onlyif  => "/usr/bin/env test \\! -f ${sentinel} || /usr/bin/env test \\! -z \"$(find /etc/apt -type f -cnewer ${sentinel})\"",
    timeout => 3600,
    notify  => Exec["initial apt-get dist-upgrade"],
  }

  exec { "initial apt-get dist-upgrade":
    refreshonly => true,
    command     => "/usr/bin/apt-get dist-upgrade -y",
    timeout     => 3600,
  }
}

class { 'apt_get_update':
  stage => pre
}

group { 'puppet':
  ensure => present,
}

include rabbitmq

rabbitmq::vhost { 'logging':
  ensure => present,
}

rabbitmq::user { 'admin':
  ensure   => present,
  password => "818f0d57",
  user_tag => administrator,
}

rabbitmq::user { 'guest':
  ensure => absent,
}

rabbitmq::permissions { 'admin':
  vhost => 'logging',
}

rabbitmq::plugin { 'rabbitmq_management':
  enable => true,
}

rabbitmq::plugin { 'eldap':
  enable => false,
}

class { 'rabbitmq::plugins::cli': 
  ensure => present,
}
