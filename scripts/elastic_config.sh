#!/bin/bash

echo "Elasticsearch: Configuring node $1"

sudo sed -i 's/#cluster.name: my-application/cluster.name: vagrant/' /etc/elasticsearch/elasticsearch.yml
sudo sed -i "s/#node.name: node-1/node.name: node-$1/" /etc/elasticsearch/elasticsearch.yml
sudo sed -i "s/#network.host: 192.168.0.1/network.host: $NODE_IP_PREFIX$1/" /etc/elasticsearch/elasticsearch.yml
sudo sed -i "s/#discovery.zen.minimum_master_nodes:/discovery.zen.minimum_master_nodes:2/" /etc/elasticsearch/elasticsearch.yml
sudo sed -i "s/#discovery.zen.ping.unicast.hosts: [\"host1\", \"host2\"]/discovery.zen.ping.unicast.hosts: [$ELASTIC_CLUSTER_NODES]/" /etc/elasticsearch/elasticsearch.yml
