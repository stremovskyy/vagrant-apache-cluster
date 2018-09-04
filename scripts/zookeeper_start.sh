#!/bin/bash
echo starting zookeeper...

#config in $ZOOKEEPER_HOME/conf/zoo.cfg
$ZOOKEEPER_HOME/bin/zkServer.sh start
sleep 2