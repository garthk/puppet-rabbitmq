class { 'rabbitmq': }

rabbitmq::user { 'admin':
  password => "818f0d57",
  user_tag => administrator,
}

rabbitmq::user { 'guest':
  ensure => absent,
}
