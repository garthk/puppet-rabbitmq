class rabbitmq::server {
  include rabbitmq
  $key = "056E8E56"
  exec { 'apt-key rabbit':
    path    => "/bin:/usr/bin",
    unless  => "apt-key list | grep '${key}'",
    command => "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${key}",
  }

  file { 'apt source rabbit':
    ensure  => present,
    path    => "/etc/apt/sources.list.d/rabbit.list",
    content => "deb http://www.rabbitmq.com/debian/ testing main\n",
  }

  exec { 'apt-get update rabbit':
    command => "/usr/bin/apt-get update",
    require => [Exec['apt-key rabbit'], File['apt source rabbit']],
    creates => "/var/lib/apt/lists/www.rabbitmq.com_debian_dists_testing_main_binary-${architecture}_Packages",
    timeout => 3600,
  }

  package { $rabbitmq::package:
    ensure  => installed,
    require => Exec['apt-get update rabbit'],
  }

  service { $rabbitmq::service:
    ensure  => running,
    enable  => true,
    require => Package[$rabbitmq::package],
  }
}
