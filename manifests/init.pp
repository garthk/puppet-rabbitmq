class rabbitmq {
  $ctl = "/usr/sbin/rabbitmqctl"
  $plugins = "/usr/sbin/rabbitmq-plugins"
  $service = "rabbitmq-server"
  include rabbitmq::server
}
