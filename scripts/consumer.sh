#!/bin/bash

if [ $# -gt 0 ]; then
    $KAFKA_HOME/bin/kafka-console-consumer.sh --from-beginning --topic $1 --bootstrap-server node1:9092,node1:9092,node3:9092
else
    echo "Usage: "$(basename $0)" <topic_name>"
fi

