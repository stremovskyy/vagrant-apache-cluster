#!/bin/bash

echo "installing Apache Ignite"

echo "downloading Ignite...$IGNITE_VERSION"

sudo yum -y install unzip

#download Zookeeper binaries if not present
if [ ! -f  $TARGET/$IGNITE_NAME.zip ]; then
   mkdir -p $TARGET
   curl -o "$TARGET/$IGNITE_NAME.zip" http://apache.ip-connect.vn.ua/ignite/"$IGNITE_VERSION/$IGNITE_NAME.zip"
fi

if [ ! -d $IGNITE_NAME ]; then 
   unzip $TARGET/$IGNITE_NAME.zip
fi

cp $IGNITE_NAME/config/default-config.xml $IGNITE_NAME/config/config.xml
sudo chown -R vagrant:vagrant $IGNITE_NAME

sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 47500:47509 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 47400 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 47100 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 47101 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 48100 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 48101 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 31100 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 31101 -j ACCEPT
