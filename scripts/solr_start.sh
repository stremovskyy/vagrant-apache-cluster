#!/bin/bash

echo "Starting Apache Ignite"

$SOLR_NAME/bin/solr start -c -m 1g -z node1:2181
sleep 2