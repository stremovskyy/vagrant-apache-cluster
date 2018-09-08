#!/bin/bash

echo "downloading Cassandra...$CASSANDRA_VERSION"

#download Zookeeper binaries if not present
if [ ! -f  $TARGET/$CASSANDRA_NAME.tar.gz ]; then
   mkdir -p $TARGET
   curl -o "$TARGET/$CASSANDRA_NAME.tar.gz" http://apache.cp.if.ua/cassandra/"$CASSANDRA_VERSION/$CASSANDRA_NAME-bin.tar.gz"
fi

if [ ! -d $CASSANDRA_NAME ]; then 
   tar -zxvf $TARGET/$CASSANDRA_NAME.tar.gz
fi

cp $CASSANDRA_NAME/conf/cassandra.yaml $CASSANDRA_NAME/conf/cassandra-default.yaml
sudo chown -R vagrant:vagrant $CASSANDRA_NAME

sudo iptables -I INPUT 1 -p tcp --dport 9042 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 7000 -j ACCEPT

echo "Done - installing Cassandra..."