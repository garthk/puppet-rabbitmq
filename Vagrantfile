# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "lucid32"
  config.vm.host_name = "rabbitmq"
  config.vm.network :hostonly, "192.168.31.45"
  config.vm.share_folder "modules/rabbitmq", "/tmp/vagrant-puppet/modules/rabbitmq", ".", :create => true
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "tests"
    puppet.manifest_file = "vagrant.pp"
    puppet.options = ["--modulepath", "/tmp/vagrant-puppet/modules"]
  end
end
