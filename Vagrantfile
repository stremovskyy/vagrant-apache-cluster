# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION ||= "2"

Vagrant.require_version '>= 2.0.2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos/7"
  config.ssh.forward_agent = true # So that boxes don't have to setup key-less ssh
  config.ssh.insert_key = false # To generate a new ssh key and don't use the default Vagrant one

  vars = { 
     "KAFKA_VERSION" => "1.1.0",
     "KAFKA_NAME" => "kafka_2.12-$KAFKA_VERSION",
     "KAFKA_TARGET" => "/vagrant/tars/",
     "KAFKA_HOME" => "$HOME/$KAFKA_NAME"
  }

  # escape environment variables to be loaded to /etc/profile.d/
  as_str = vars.map{|k,str| ["export #{k}=#{str.gsub '$', '\$'}"] }.join("\n")

  # common provisioning for all 
  config.vm.provision "shell", path: "scripts/hosts-file-setup.sh", env: vars
  config.vm.provision "shell", inline: "echo \"#{as_str}\" > /etc/profile.d/kafka_vagrant_env.sh", run: "always"
  config.vm.provision "shell", path: "scripts/init.sh", env: vars
 
  # configure brokers
  (1..3).each do |i|
    config.vm.define "broker#{i}" do |s|
      s.vm.hostname = "broker#{i}"
      # s.vm.network "private_network", ip: "10.30.3.#{i}0"
      s.vm.network "public_network", ip: "192.168.1.2#{i}0" ,bridge: "en0: Ethernet"
      s.vm.provision "shell", run: "always", path: "scripts/broker.sh", args:"#{i}", privileged: false, env: vars
      s.vm.provision "shell", run: "always", path: "scripts/zookeeper.sh", args:"#{i}", privileged: false, env: vars
    end
  end

  config.vm.provider "virtualbox" do |v|
    #  This setting controls how much cpu time a virtual CPU can use. A value of 50 implies a single virtual CPU can use up to 50% of a single host CPU.
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end
end
