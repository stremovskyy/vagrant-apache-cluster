#!/bin/bash

#bootstrap hosts file

if [ $# -gt 0 ]; then
    sed -i "$ a 192.168.1.2$1 $NODE_NAME_PREFIX$1" /etc/hosts
else
    #need for normal working zookeeper server
    sudo sed -i '1d' /etc/hosts
fi