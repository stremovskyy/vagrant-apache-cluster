#!/bin/bash

echo "Configuring Apache Ignite"

sed -i 's#/>#>#' $IGNITE_HOME/config/config.xml
sed -i '/IgniteConfiguration/s/$/\n\t<!-- config -->\n<\/bean>/' $IGNITE_HOME/config/config.xml
sed -i  '/<!-- config -->/s/$/\n\n/' $IGNITE_HOME/config/config.xml
sed -i  '/<!-- config -->/s/$/\n\n<property name="discoverySpi">\n\t<bean class="org.apache.ignite.spi.discovery.zk.ZookeeperDiscoverySpi">\n\t\t<property name="zkConnectionString" value="127.0.0.1:2181"\/>\n\t\t<property name="sessionTimeout" value="30000"\/>\n\t\t<property name="zkRootPath" value="\/apacheIgnite"\/>\n\t\t<property name="joinTimeout" value="10000"\/>\n\t<\/bean>\n<\/property>/' $IGNITE_HOME/config/config.xml
