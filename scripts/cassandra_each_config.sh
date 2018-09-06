#!/bin/bash

sudo sed -i "/- seeds: /s/.$//" $CASSANDRA_HOME/conf/cassandra.yaml
sudo sed -i "/- seeds: /s/$/node$1,\"/" $CASSANDRA_HOME/conf/cassandra.yaml