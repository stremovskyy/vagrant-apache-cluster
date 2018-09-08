#!/bin/bash

echo "Start - installing Kafka..."

echo "downloading kafka...$KAFKA_VERSION"
#download kafka binaries if not present
if [ ! -f  $TARGET/$KAFKA_NAME.tgz ]; then
   mkdir -p $TARGET
   curl -o "$TARGET/$KAFKA_NAME.tgz" http://apache.mirrors.hoobly.com/kafka/"$KAFKA_VERSION/$KAFKA_NAME.tgz"
fi

if [ ! -d $KAFKA_NAME ]; then 
   tar -zxvf $TARGET/$KAFKA_NAME.tgz
fi

chown vagrant:vagrant -R $KAFKA_NAME

sudo iptables -I INPUT 1 -p tcp --dport 9092 -j ACCEPT

echo "Done - installing Kafka..."