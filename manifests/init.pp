class rabbitmq {
  $ctl = "/usr/sbin/rabbitmqctl"
  $plugins = "/usr/sbin/rabbitmq-plugins"
  $service = "rabbitmq-server"
  $package = "rabbitmq-server"
  include rabbitmq::server
}
