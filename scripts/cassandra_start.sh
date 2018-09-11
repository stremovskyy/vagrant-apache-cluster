#!/bin/bash

echo "Starting Cassandra Server..."
nohup $CASSANDRA_NAME/bin/cassandra > cassandra.out &
sleep 2