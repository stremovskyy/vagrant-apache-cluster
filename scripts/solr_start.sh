#!/bin/bash

echo "Starting Apache Solr"

nohup $SOLR_NAME/bin/solr start -c -h $NODE_NAME_PREFIX$1 -z $ZK_NODES/solr > solr.out &
sleep 2
