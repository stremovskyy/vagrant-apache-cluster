#!/bin/bash

sudo sed -i "/- seeds: /s/.$//" /etc/cassandra/conf/cassandra.yaml
sudo sed -i "/- seeds: /s/$/node$1,\"/" /etc/cassandra/conf/cassandra.yaml