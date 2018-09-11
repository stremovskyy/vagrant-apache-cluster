#!/bin/bash

echo "Configuring Apache Cassandra"

sudo sed -i 's/Test Cluster/Vagrant Cluster/' $CASSANDRA_HOME/conf/cassandra.yaml
sudo sed -i 's/endpoint_snitch: SimpleSnitch/endpoint_snitch: GossipingPropertyFileSnitch/' $CASSANDRA_HOME/conf/cassandra.yaml
sudo sed -i "s/localhost/$NODE_NAME_PREFIX$1/" $CASSANDRA_HOME/conf/cassandra.yaml
sudo sed -i 's/- seeds: "127.0.0.1"/- seeds: "$CLUSTER_NODES"/' $CASSANDRA_HOME/conf/cassandra.yaml
sudo sed -i '$ a auto_bootstrap: false' $CASSANDRA_HOME/conf/cassandra.yaml


