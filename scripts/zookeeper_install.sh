#!/bin/bash

echo "Start - installing Zookeeper..."

echo "downloading Zookeeper...$ZOOKEEPER_VERSION"

#download Zookeeper binaries if not present
if [ ! -f  $TARGET/$ZOOKEEPER_NAME.tar.gz ]; then
   curl -o "$TARGET/$ZOOKEEPER_NAME.tar.gz" http://apache.cp.if.ua/zookeeper/"$ZOOKEEPER_NAME/$ZOOKEEPER_NAME.tar.gz"
fi

if [ ! -d $ZOOKEEPER_NAME ]; then 
   tar -zxvf $TARGET/$ZOOKEEPER_NAME.tar.gz
fi

cp $ZOOKEEPER_NAME/conf/zoo_sample.cfg $ZOOKEEPER_NAME/conf/zoo.cfg
sudo mkdir $ZOOKEEPER_DATA
sudo chown vagrant:vagrant -R $ZOOKEEPER_NAME
sudo chown vagrant:vagrant -R $ZOOKEEPER_DATA

sudo iptables -I INPUT 1 -p tcp --dport 3888 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 2888 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 2181 -j ACCEPT

echo "Done - installing Zookeeper..."