#!/bin/bash

if [ $# -gt 0 ]; then
    $KAFKA_HOME/bin/kafka-console-producer.sh --topic "$1" --broker-list node1:9092,node1:9092,node3:9092
else
    echo "Usage: "$(basename $0)" <topic_name>"
fi
