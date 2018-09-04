#!/bin/bash

#bootstrap zookeeper server config file
if [ $# -gt 0 ]; then
    sed -i "$ a server.$1=node$1:2888:3888" $ZOOKEEPER_HOME/conf/zoo.cfg
else
    sed -i "s#dataDir=/tmp/zookeeper#dataDir=$ZOOKEEPER_DATA#" $ZOOKEEPER_HOME/conf/zoo.cfg
    echo $1 > $ZOOKEEPER_DATA/myid
fi