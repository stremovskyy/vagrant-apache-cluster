#!/bin/bash

echo "Starting Apache Hadoop"


$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh

sleep 2