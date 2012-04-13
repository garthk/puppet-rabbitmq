class { 'rabbitmq': }

rabbitmq::plugin { 'rabbitmq_management': }

rabbitmq::plugin { 'eldap':
  enable => false,
}
