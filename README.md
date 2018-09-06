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

Each host is a Centos 6.9 64-bit VM provisioned with JDK 8 

Versions and Info
-------------------------

* Apache Kafka 2.0.0
* Apache Zookeeper 3.4.6
* Dynamic hosts number

Prerequisites
-------------------------

* Vagrant (tested with 2.0.2) **[make sure you are on 2.x.x version of Vagrant]**
* VirtualBox (tested with 5.1.12)

Setup
-------------------------

To start it up, just git clone this repo and execute ```vagrant up```. This will take a while the first time as it downloads all required dependencies for you.

Kafka is installed on all hosts and can be easily accessed through the environment variable ```$KAFKA_HOME```

Zookeeper servers bind to port 2181. Kafka brokers bind to port 9092. 
