#!/bin/bash

$KAFKA_HOME/bin/kafka-topics.sh --describe --zookeeper node1:2181,node1:2181,node3:2181
