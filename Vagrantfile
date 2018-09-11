# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

VAGRANTFILE_API_VERSION ||= "2"
Vagrant.require_version '>= 2.0.2'

confDir = $confDir ||= File.expand_path(File.dirname(__FILE__)) + '/config'
confFile = confDir + "/config.yaml"

if File.exist? confFile then
  settings = YAML::load(File.read(confFile))
else
  abort "Settings file not found in #{confDir}"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos/7"
  config.ssh.forward_agent = true # So that boxes don't have to setup key-less ssh
  config.ssh.insert_key = false # To generate a new ssh key and don't use the default Vagrant one

  cluster_nodes = ""
  zk_nodes = ""
  (1..settings['cluster_size']).each do |y|
    if y == settings['cluster_size']
      cluster_nodes = cluster_nodes + settings['node_name_prfix'] + "#{y}"
      zk_nodes = zk_nodes + settings['node_name_prfix'] + "#{y}:2181"
    else
      cluster_nodes = cluster_nodes + settings['node_name_prfix'] + "#{y},"
      zk_nodes = zk_nodes + settings['node_name_prfix'] + "#{y}:2181,"
    end
  end

  vars = {
    "TARGET" => "/vagrant/tars",
    "NODE_NAME_PREFIX" => settings['node_name_prfix'],
    "CLUSTER_NODES" => cluster_nodes,
    "ZK_NODES" => zk_nodes,

    "KAFKA_VERSION" => settings['apache_kafka']['version'],
    "KAFKA_NAME" => "kafka_2.12-$KAFKA_VERSION",
    "KAFKA_HOME" => "$HOME/$KAFKA_NAME",

    "ZOOKEEPER_VERSION" => settings['zookeeper']['version'],
    "ZOOKEEPER_NAME" => "zookeeper-$ZOOKEEPER_VERSION",
    "ZOOKEEPER_HOME" => "$HOME/$ZOOKEEPER_NAME",
    "ZOOKEEPER_DATA" => "/var/lib/zookeeper",

    "IGNITE_VERSION" => settings['ignite']['version'],
    "IGNITE_NAME" => "apache-ignite-fabric-$IGNITE_VERSION-bin",
    "IGNITE_HOME" => "$HOME/$IGNITE_NAME",
    "IGNITE_DATA" => "/var/lib/ignite",

    "CASSANDRA_VERSION" => settings['cassandra']['version'],
    "CASSANDRA_NAME" => "apache-cassandra-$CASSANDRA_VERSION",
    "CASSANDRA_HOME" => "$HOME/$CASSANDRA_NAME",
    "CASSANDRA_DATA" => "/var/lib/cassandra",

    "SOLR_VERSION" => settings['solr']['version'],
    "SOLR_NAME" => "solr-$SOLR_VERSION",
    "SOLR_HOME" => "$HOME/$SOLR_NAME/server/solr",
    "SOLR_DATA" => "/var/lib/SOLR",

    "HADOOP_VERSION" => settings['hadoop']['version'],
    "HADOOP_NAME" => "hadoop-$HADOOP_VERSION",
    "HADOOP_HOME" => "$HOME/$HADOOP_NAME",
    "HADOOP_DATA" => "/var/lib/hadoop",
  }

  # escape environment variables to be loaded to /etc/profile.d/
  as_str = vars.map{|k,str| ["export #{k}=#{str.gsub '$', '\$'}"] }.join("\n")

  # common provisioning for all
  config.vm.provision "shell", inline: "echo \"#{as_str}\" > /etc/profile.d/kafka_vagrant_env.sh", run: "always"
  config.vm.provision "shell", path: "scripts/init.sh", env: vars, privileged: true
  config.vm.provision "shell", path: "scripts/hosts_config.sh", privileged: true, env: vars 

  if settings['zookeeper']['install']
    config.vm.provision "shell", path: "scripts/zookeeper_install.sh",privileged: false, env: vars
    config.vm.provision "shell", path: "scripts/zookeeper_config.sh", privileged: false, env: vars 
  end

  if settings['apache_kafka']['install']
    config.vm.provision "shell", path: "scripts/kafka_install.sh", env: vars
  end

  if settings['cassandra']['install']
    config.vm.provision "shell", path: "scripts/cassandra_install.sh", env: vars
  end

  if settings['solr']['install']
    config.vm.provision "shell", path: "scripts/solr_install.sh", env: vars
  end

  if settings['hadoop']['install']
    config.vm.provision "shell", path: "scripts/hadoop_install.sh", env: vars
  end
 
  if settings['ignite']['install']
    config.vm.provision "shell", path: "scripts/ignite_install.sh", env: vars
    if settings['zookeeper']['install']
      config.vm.provision "shell", path: "scripts/ignite_config_zk.sh",privileged: false, env: vars
    end
  end

  # configure nodes
  (1..settings['cluster_size']).each do |i|
    config.vm.define settings['node_name_prfix'] + "#{i}" do |s|
      s.vm.hostname = settings['node_name_prfix'] + "#{i}"
      s.vm.post_up_message = "Virtal node name: " + settings['node_name_prfix'] + "#{i}"
      
      if settings['private']['enable']
        s.vm.network "private_network", ip: settings['private']['prefix_ip'] + "#{i}"
        s.vm.post_up_message = "Private IP: " + settings['private']['prefix_ip'] + "#{i}"
      end

      if settings['public']['enable']
        s.vm.network "public_network", ip: settings['public']['prefix_ip'] + "#{i}" , bridge: settings['public']['bridge']
        s.vm.post_up_message = "Public IP: " + settings['public']['prefix_ip'] + "#{i}"
      end

      # Config services

      if settings['zookeeper']['install']
            s.vm.provision "shell", path: "scripts/zookeeper_each_config.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['apache_kafka']['install']
        s.vm.provision "shell", path: "scripts/kafka_config.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['cassandra']['install']
        s.vm.provision "shell", path: "scripts/cassandra_config.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['ignite']['install']
        s.vm.provision "shell", path: "scripts/ignite_config.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['solr']['install']
        s.vm.provision "shell", path: "scripts/solr_config.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['hadoop']['install']
        s.vm.provision "shell", path: "scripts/hadoop_config.sh", args:"#{i}", privileged: false, env: vars
      end

      # Config Each service

      (1..settings['cluster_size']).each do |z|
        if settings['private']['enable']
          s.vm.provision "shell",  path: "scripts/hosts_config.sh", args:[settings['private']['prefix_ip']+"#{z}","#{z}"], privileged: true, env: vars 
        end

        if settings['public']['enable']
           s.vm.provision "shell",  path: "scripts/hosts_config.sh", args:[settings['public']['prefix_ip']+"#{z}","#{z}"], privileged: true, env: vars 
        end
        
        if settings['zookeeper']['install']
          s.vm.provision "shell",  path: "scripts/zookeeper_config.sh", args:"#{z}", privileged: false, env: vars 
        end
      end

      # Starting services

      if settings['zookeeper']['install']
        s.vm.provision "shell", run: "always", path: "scripts/zookeeper_start.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['apache_kafka']['install']
        s.vm.provision "shell", run: "always", path: "scripts/kafka_start.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['cassandra']['install']
        s.vm.provision "shell", run: "always", path: "scripts/cassandra_start.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['ignite']['install']
        s.vm.provision "shell", run: "always", path: "scripts/ignite_start.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['solr']['install']
        s.vm.provision "shell", run: "always", path: "scripts/solr_start.sh", args:"#{i}", privileged: false, env: vars
      end

      if settings['hadoop']['install']
        s.vm.provision "shell", run: "always", path: "scripts/hadoop_start.sh", args:"#{i}", privileged: false, env: vars
      end
    end
  end

  config.vm.provider "virtualbox" do |v|
    #  This setting controls how much cpu time a virtual CPU can use. A value of 50 implies a single virtual CPU can use up to 50% of a single host CPU.
    v.customize ["modifyvm", :id, "--cpuexecutioncap", settings['max_cpu_precent']]
      if settings['cassandra']['install']
        v.customize ["modifyvm", :id, "--memory", settings['max_memory']]
      end
  end
end
