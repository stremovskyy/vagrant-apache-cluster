#!/bin/bash

echo "Configuring Apache Ignite"

sed -i 's#/>#>#' $IGNITE_HOME/config/config.xml
sed -i '/IgniteConfiguration/s/$/\n\t<!-- config -->\n<\/bean>/' $IGNITE_HOME/config/config.xml
sed -i  '/<!-- config -->/s/$/\n\n/' $IGNITE_HOME/config/config.xml
sed -i  '/<!-- config -->/s/$/\n\t\t<property name="cacheConfiguration">\n\t\t\t<list>\n\t\t\t\t<!-- Partitioned cache example configuration (Atomic mode). -->\n\t\t\t\t<bean class="org.apache.ignite.configuration.CacheConfiguration">\n\t\t\t\t\t<property name="name" value="default"\/>\n\t\t\t\t\t<property name="atomicityMode" value="ATOMIC"\/>\n\t\t\t\t\t<property name="cacheMode" value="REPLICATED"\/>\n\t\t\t\t\t<property name="backups" value="1"\/>\n\t\t\t\t<\/bean>\n\t\t\t<\/list>\n\t\t<\/property>/' $IGNITE_HOME/config/config.xml
sed -i  '/<!-- config -->/s/$/\n\t\t<property name="odbcConfiguration">\n\t\t<bean class="org.apache.ignite.configuration.OdbcConfiguration">\n\t\t<\/bean>\n\t\t<\/property>/' $IGNITE_HOME/config/config.xml