#!/bin/bash

echo "Starting Apache Ignite"

nohup $IGNITE_HOME/bin/ignite.sh $IGNITE_NAME/config/config.xml &
sleep 2