#!/bin/bash

echo Bootstraping hosts file

if [ $# -gt 0 ]; then
    sed -i "$ a $1 $NODE_NAME_PREFIX$2" /etc/hosts
else
    #need for normal working zookeeper server
    sudo sed -i '1d' /etc/hosts
fi