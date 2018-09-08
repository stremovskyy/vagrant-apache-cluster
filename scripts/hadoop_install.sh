#!/bin/bash

echo "installing Apache Hadoop"

echo "downloading Hadoop...$HADOOP_VERSION"

#download Zookeeper binaries if not present
if [ ! -f  $TARGET/$HADOOP_NAME.tar.gz ]; then
   mkdir -p $TARGET
   curl -o "$TARGET/$HADOOP_NAME.tar.gz" http://apache.cp.if.ua/hadoop/common/hadoop-"$HADOOP_VERSION/$HADOOP_NAME.tar.gz"
fi

if [ ! -d $HADOOP_NAME ]; then 
   tar -zxvf  $TARGET/$HADOOP_NAME.tar.gz
fi

export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

sudo chown -R vagrant:vagrant $HADOOP_NAME

sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 8020 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9000 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50090 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50010 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50075 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50020 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50070 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50475 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50470 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9001 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50030 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 50060 -j ACCEPT

