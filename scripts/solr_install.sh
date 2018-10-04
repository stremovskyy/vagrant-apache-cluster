#!/bin/bash

echo "downloading Solr...$SOLR_VERSION"

#download Zookeeper binaries if not present
if [ ! -f  $TARGET/$SOLR_NAME.tgz ]; then
   curl -o "$TARGET/$SOLR_NAME.tgz" http://apache.cp.if.ua/lucene/solr/"$SOLR_VERSION/$SOLR_NAME.tgz"
fi

if [ ! -d $SOLR_NAME ]; then 
   tar -zxvf $TARGET/$SOLR_NAME.tgz
fi


sudo sysctl -p /etc/sysctl.conf
sudo sysctl -w fs.file-max=100000
sysctl --system

sudo iptables -I INPUT 1 -p tcp --dport 8983 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 7574 -j ACCEPT

sudo chown -R vagrant:vagrant $SOLR_NAME

echo "Done - installing SOLR..."