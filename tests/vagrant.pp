class test_server {
  group { 'puppet': 
    ensure => present,
  }

  include rabbitmq
}

include test_server
