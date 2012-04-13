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
