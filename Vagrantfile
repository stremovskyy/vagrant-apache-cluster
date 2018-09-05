# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION ||= "2"
CLUSTER_SIZE ||= 3

INSTALL_ZOOKEEPER ||= true
ZOOKEEPER_VERSION ||= "3.4.13"

INSTALL_KAFKA ||= true
KAFKA_VERSION ||= "2.0.0"

INSTALL_CASSANDRA ||= true

# INSTALL_IGNITE ||= false
# INSTALL_SPARK ||= false
# INSTALL_HDFS ||= false

Vagrant.require_version '>= 2.0.2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos/7"
  config.ssh.forward_agent = true # So that boxes don't have to setup key-less ssh
  config.ssh.insert_key = false # To generate a new ssh key and don't use the default Vagrant one

  vars = { 
    "TARGET" => "/vagrant/tars",

    "KAFKA_VERSION" => KAFKA_VERSION,
    "KAFKA_NAME" => "kafka_2.12-$KAFKA_VERSION",
    "KAFKA_HOME" => "$HOME/$KAFKA_NAME",

    "ZOOKEEPER_VERSION" => ZOOKEEPER_VERSION,
    "ZOOKEEPER_NAME" => "zookeeper-$ZOOKEEPER_VERSION",
    "ZOOKEEPER_HOME" => "$HOME/$ZOOKEEPER_NAME",
    "ZOOKEEPER_DATA" => "/var/zookeeper"
  }

  # escape environment variables to be loaded to /etc/profile.d/
  as_str = vars.map{|k,str| ["export #{k}=#{str.gsub '$', '\$'}"] }.join("\n")

  # common provisioning for all 
  config.vm.provision "shell", inline: "echo \"#{as_str}\" > /etc/profile.d/kafka_vagrant_env.sh", run: "always"
  config.vm.provision "shell", path: "scripts/init.sh", env: vars, privileged: true
  config.vm.provision "shell", path: "scripts/hosts_config.sh", privileged: true, env: vars 

  if INSTALL_ZOOKEEPER
    config.vm.provision "shell", path: "scripts/zookeeper_install.sh",privileged: false, env: vars
    config.vm.provision "shell", path: "scripts/zookeeper_config.sh", privileged: false, env: vars 
  end

  if INSTALL_KAFKA 
    config.vm.provision "shell", path: "scripts/kafka_install.sh", env: vars
  end

  if INSTALL_CASSANDRA 
    config.vm.provision "shell", path: "scripts/cassandra_install.sh", env: vars
  end
 
  # configure nodes
  (1..CLUSTER_SIZE).each do |i|
    config.vm.define "node#{i}" do |s|
      s.vm.hostname = "node#{i}"
      # s.vm.network "private_network", ip: "10.20.30.#{i}"

# Config services

  if INSTALL_ZOOKEEPER
        s.vm.provision "shell", path: "scripts/zookeeper_each_config.sh", args:"#{i}", privileged: false, env: vars
      end

      if INSTALL_KAFKA
        s.vm.provision "shell", path: "scripts/kafka_config.sh", args:"#{i}", privileged: false, env: vars
      end

      if INSTALL_CASSANDRA
        s.vm.provision "shell", path: "scripts/cassandra_config.sh", args:"#{i}", privileged: false, env: vars
      end

# Config Each service

        (1..CLUSTER_SIZE).each do |z|
          s.vm.provision "shell",  path: "scripts/hosts_config.sh", args:"#{z}", privileged: true, env: vars 
          
          if INSTALL_ZOOKEEPER
            s.vm.provision "shell",  path: "scripts/zookeeper_config.sh", args:"#{z}", privileged: false, env: vars 
          end
          
          if INSTALL_KAFKA 
            s.vm.provision "shell",  path: "scripts/kafka_broker_config.sh", args:"#{z}", privileged: false, env: vars 
          end
          
          if INSTALL_CASSANDRA 
            s.vm.provision "shell",  path: "scripts/cassandra_each_config.sh", args:"#{z}", privileged: false, env: vars 
          end
        end
      s.vm.network "public_network", ip: "192.168.1.2#{i}" ,bridge: "en0: Ethernet"

# Starting services

      if INSTALL_ZOOKEEPER
        s.vm.provision "shell", run: "always", path: "scripts/zookeeper_start.sh", args:"#{i}", privileged: false, env: vars
      end

      if INSTALL_KAFKA
        s.vm.provision "shell", run: "always", path: "scripts/kafka_start.sh", args:"#{i}", privileged: false, env: vars
      end

      if INSTALL_CASSANDRA
        s.vm.provision "shell", run: "always", path: "scripts/cassandra_start.sh", args:"#{i}", privileged: true, env: vars
      end
    end
  end

  config.vm.provider "virtualbox" do |v|
    #  This setting controls how much cpu time a virtual CPU can use. A value of 50 implies a single virtual CPU can use up to 50% of a single host CPU.
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      if INSTALL_CASSANDRA
        v.customize ["modifyvm", :id, "--memory", 2048]
      end
  end
end
