#!/bin/bash

echo "Starting Apache Ignite"

nohup $IGNITE_HOME/bin/ignite.sh $IGNITE_HOME/config/config.xml > ignite.out 2>&1 &
sleep 2