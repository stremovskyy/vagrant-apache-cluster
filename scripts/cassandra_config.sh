#!/bin/bash

echo "Configuring Apache Cassandra"

sudo sed -i 's/Test Cluster/Vagrant Cluster/' /etc/cassandra/conf/cassandra.yaml
sudo sed -i 's/endpoint_snitch: SimpleSnitch/endpoint_snitch: GossipingPropertyFileSnitch/' /etc/cassandra/conf/cassandra.yaml
sudo sed -i "s/localhost/node$1/" /etc/cassandra/conf/cassandra.yaml
sudo sed -i 's/- seeds: "127.0.0.1"/- seeds: ""/' /etc/cassandra/conf/cassandra.yaml
sudo sed -i '$ a auto_bootstrap: false' /etc/cassandra/conf/cassandra.yaml


