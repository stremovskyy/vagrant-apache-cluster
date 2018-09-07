#!/bin/bash

#bootstrap zookeeper server config file

if [ $# -gt 0 ]; then
    echo $1 > $ZOOKEEPER_DATA/myid
fi