#!/bin/bash

echo "installing Apache Hadoop"

echo "downloading Hadoop...$HADOOP_VERSION"

if [ ! -f  $TARGET/$HADOOP_NAME.tar.gz ]; then
   curl -o "$TARGET/$HADOOP_NAME.tar.gz" http://apache.cp.if.ua/hadoop/common/hadoop-"$HADOOP_VERSION/$HADOOP_NAME.tar.gz"
fi

if [ ! -d $HADOOP_NAME ]; then 
   tar -zxvf  $TARGET/$HADOOP_NAME.tar.gz
fi

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

tee -a .bashrc << EOF
export JAVA_HOME=$JAVA_HOME
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
EOF

source .bashrc


mkdir -p $HADOOP_HOME/hadoopdata/hdfs/namenode
mkdir -p $HADOOP_HOME/hadoopdata/hdfs/datanode

sed -i 's#<configuration>#<configuration>\n<property>\n\t<name>fs.default.name</name>\n\t\t<value>hdfs://localhost:9000</value>\n</property>#' $HADOOP_HOME/etc/hadoop/core-site.xml
sed -i 's#<configuration>#<configuration>\n\t<property>\n\t<name>mapreduce.framework.name</name>\n\t\t<value>yarn</value>\n\t</property>#' $HADOOP_HOME/etc/hadoop/mapred-site.xml
sed -i 's#<configuration>#<configuration>\n<property>\n\t<name>yarn.nodemanager.aux-services</name>\n\t\t<value>mapreduce_shuffle</value>\n\t</property>#' $HADOOP_HOME/etc/hadoop/yarn-site.xml
sed -i "s#<configuration>#<configuration>\n<property>\n\t<name>dfs.replication</name>\n\t\t<value>1</value>\n</property>\n\n<property>\n\t<name>dfs.name.dir</name>\n\t\t<value>file://$HADOOP_HOME/hadoopdata/hdfs/namenode</value>\n</property>\n\n<property>\n\t<name>dfs.data.dir</name>\n\t\t<value>file://$HADOOP_HOME/hadoopdata/hdfs/datanode</value>\n</property>#" $HADOOP_HOME/etc/hadoop/hdfs-site.xml

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

