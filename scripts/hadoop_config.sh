#!/bin/bash

echo "Configuring Apache Hadoop"

ssh-keygen -t rsa -f /home/vagrant/.ssh/id_rsa -q -P ""
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub

nohup $HADOOP_HOME/bin/hdfs namenode -format &

# $HADOOP_HOME/bin/hdfs dfs -mkdir /hadooptest
# $HADOOP_HOME/bin/hdfs dfs -put .bashrc /hadooptest
# $HADOOP_HOME/bin/hdfs dfs -get /hadooptest
