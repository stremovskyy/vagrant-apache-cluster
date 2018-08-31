#!/bin/bash

$KAFKA_HOME/bin/kafka-topics.sh --describe --zookeeper br1:2181,br2:2181,br3:2181
