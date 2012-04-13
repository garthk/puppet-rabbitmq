class rabbitmq::server {
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
    require => File['apt source rabbit'],
    creates => "/var/lib/apt/lists/www.rabbitmq.com_debian_dists_testing_main_binary-i386_Packages",
    timeout => 3600,
  }

  exec { 'apt-get install rabbit': 
    # necessary for the time being because of authentication problems
    command => "/usr/bin/apt-get -qy --force-yes install rabbitmq-server",
    unless  => "/usr/bin/dpkg --get-selections rabbitmq-server | grep -v deinstall",
    require => [Exec['apt-get update rabbit'], Exec['apt-key rabbit']],
  }

  #package { 'rabbitmq-server':
  #  ensure  => installed,
  #  require => [Exec['apt-get update rabbit'], Exec['apt-key rabbit']],
  #}

  service { $rabbitmq::service:
    ensure  => running,
    enable  => true,
    require => Exec['apt-get install rabbit'],
  }
}
