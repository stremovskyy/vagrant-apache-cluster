#!/bin/bash

echo "downloading SOLR...$SOLR_VERSION"

#download Zookeeper binaries if not present
if [ ! -f  $TARGET/$SOLR_NAME.tgz ]; then
   mkdir -p $TARGET
   curl -o "$TARGET/$SOLR_NAME.tgz" http://apache.cp.if.ua/lucene/solr/"$SOLR_VERSION/$SOLR_NAME.tgz"
fi

if [ ! -d $SOLR_NAME ]; then 
   tar -zxvf $TARGET/$SOLR_NAME.tgz
fi

sudo chown -R vagrant:vagrant $SOLR_NAME
sudo sysctl -p /etc/sysctl.conf
sudo sysctl -w fs.file-max=100000
sysctl --system
sudo iptables -I INPUT 1 -p tcp --dport 8983 -j ACCEPT

echo "Done - installing SOLR..."