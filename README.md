Puppet module for [RabbitMQ] on Ubuntu. 

## Installation

    cd /etc/puppet/modules
    git clone git://github.com/garthk/puppet-rabbit rabbit

## Usage

    include rabbit

The class will:

* Import [RabbitMQ's signing key][056E8E56] from `keyserver.ubuntu.com`
* Add RabbitMQ's apt source to `/etc/apt/sources.list.d'
* Perform `apt-get update`
* Install [RabbitMQ]

[056E8E56]: http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0xF7B8CEA6056E8E56

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
