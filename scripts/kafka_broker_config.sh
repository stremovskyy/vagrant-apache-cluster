#!/bin/bash

#bootstrap kafka server config file
sed -i "/zookeeper.connect=/s/$/$NODE_NAME_PREFIX$1:2181,/" $KAFKA_HOME/config/server.properties