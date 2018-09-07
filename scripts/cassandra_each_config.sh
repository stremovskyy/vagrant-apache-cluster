#!/bin/bash

sudo sed -i "/- seeds: /s/.$//" $CASSANDRA_HOME/conf/cassandra.yaml
sudo sed -i "/- seeds: /s/$/$NODE_NAME_PREFIX$1,\"/" $CASSANDRA_HOME/conf/cassandra.yaml