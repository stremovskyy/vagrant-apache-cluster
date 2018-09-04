#!/bin/bash

#bootstrap kafka server config file
sed -i "/zookeeper.connect=/s/$/node$1:2181,/" $KAFKA_HOME/config/server.properties