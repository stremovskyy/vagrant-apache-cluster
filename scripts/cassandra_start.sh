#!/bin/bash

echo "Starting Cassandra Server..."
nohup $CASSANDRA_NAME/bin/cassandra ignite.log 2>&1 &
sleep 2