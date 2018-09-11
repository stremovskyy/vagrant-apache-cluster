Vagrant Apache cluster
=============
Vagrant configuration to setup a Apache cluster.

In the box
-------------------------

* Apache Kafka Cluster
* Apache Zookeeper Cluster
* Apache Cassandra Cluster
* Apache Ignite Cluster

Partitioned Apache Kafka installation with clustered Apache Zookeeper.

This configuration will start and provision CentOS7 VMs:

* Hosts forming a nodes Apache Zookeeper Quorum (Replicated ZooKeeper)
* Apache Kafka nodes with one broker each

Each host is a Centos 7 64-bit VM provisioned with JDK 8 

Versions and Info
-------------------------

* Apache Kafka **2.0.0**
* Apache Zookeeper **3.4.13**
* Apache Cassandra **3.11.3**
* Apache Ignite **2.6.0**
* Dynamic hosts number

> Versions can be edited in ```config/config.yaml```

Prerequisites
-------------------------

* Vagrant (tested with 2.0.2) **[make sure you are on 2.x.x version of Vagrant]**
* VirtualBox (tested with 5.1.12)

Setup
-------------------------

To start it up, just git clone this repo and execute ```vagrant up```. This will take a while the first time as it downloads all required dependencies for you.

Kafka is installed on all hosts and can be easily accessed through the environment variable ```$KAFKA_HOME```

Zookeeper servers bind to port 2181. Kafka brokers bind to port 9092. 

Setup
-------------------------

To check Apache Cassandra Cluster Status use:
`$CASSANDRA_NAME/bin/nodetool status`
And get something like this:
```
Datacenter: dc1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address        Load       Tokens       Owns (effective)  Host ID                               Rack
UN  192.168.1.111  69.92 KiB  256          65.8%             775f57ec-6950-4783-9bc9-1dfb8cceda76  rack1
UN  192.168.1.112  105.24 KiB  256          69.3%             6d6d075e-6680-4097-b2f5-52f631868867  rack1
UN  192.168.1.113  69.94 KiB  256          65.0%             c6b6d23d-13ec-4389-b8d7-30c45ec976ce  rack1
```

Known Issues
-------------------------

> After `vagrant up` first node is not active
>> Just `vagrant reload <first node name>`, it's because first node after start, not finded other nodes.

> Can't start any script from `vagrant/scripts` directory
>> Very strange problem, but `sudo chmod u+x /vagrant/scripts/*.sh` can help