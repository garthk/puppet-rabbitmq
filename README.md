Puppet module for [RabbitMQ] on Ubuntu. 

## Installation

    cd /etc/puppet/modules
    git clone git://github.com/garthk/puppet-rabbitmq rabbitmq

## Usage

    include rabbitmq

The class will:

* Import [RabbitMQ's signing key][056E8E56] from `keyserver.ubuntu.com`
* Add RabbitMQ's apt source to `/etc/apt/sources.list.d'
* Perform `apt-get update`
* Install [RabbitMQ]

[056E8E56]: http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0xF7B8CEA6056E8E56

### VHosts

    rabbitmq::vhost { 'logging':
      ensure => present,
    }

* `ensure` is optional, defaulting to `present`.
* `ensure => absent` will remove the vhost.

### Users

    rabbitmq::user { 'admin':
      ensure   => present,
      password => "818f0d57",
      user_tag => administrator,
    }

    rabbitmq::user { 'guest':
      ensure => absent,
    }

* `ensure` is optional, defaulting to `present`.
* `password` is mandatory if `ensure => present`.
* `user_tag` is optional, defaulting to `""`; useful values are
  `administrator`, `monitoring`, and `management`.

### Permissions

    rabbitmq::permissions { 'admin@logging':
      user  => 'admin',
      vhost => 'logging',
      conf  => '.*',
      write => '.*',
      read  => '.*',
    }

    rabbitmq::permissions { 'boris':
      ensure => absent,
      vhost => 'logging',
    }

* `user` is optional, defaulting to the `$name` (e.g. `boris` above)
* `ensure` is optional, defaulting to `present`.
* `vhost` is optional, defaulting to `/`.
* `ensure => absent` strips all permissions on the `vhost` regardless of
  the other arguments.
* `conf`, `write`, and `read` are optional, defaulting to `".*"`

### Plugins

    rabbitmq::plugin { 'rabbitmq_management':
      enable => true,
    }

    rabbitmq::plugin { 'eldap':
      enable => false,
    }

* `ensure` is optional, defaulting to `present`.

#### CLI

    class { 'rabbitmq::plugins::cli': 
      ensure => present,
    }

* `ensure` is optional, defaulting to `present`.
* if `ensure => present`, you'll get `/usr/sbin/rabbitmqadmin` with
  command auto-completion on `bash`.

## Testing:

### Smoke Testing

* `make test` or `make smoke` to perform a simple [smoke test]

### Vagrant

* Install [Vagrant]

* Get the `lucid32` box (safe even if you already have it):

        vagrant box add lucid32 http://files.vagrantup.com/lucid32.box

* Launch the virtual machine:

        vagrant up

[RabbitMQ]: http://www.rabbitmq.com/
[Vagrant]: http://vagrantup.com/
[smoke test]: http://docs.puppetlabs.com/guides/tests_smoke.html
[get in touch]: http://twitter.com/garthk
