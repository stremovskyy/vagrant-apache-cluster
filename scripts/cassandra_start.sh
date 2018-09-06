#!/bin/bash

echo "Starting Cassandra Server..."
nohup $CASSANDRA_NAME/bin/cassandra &
sleep 2