#!/bin/bash

echo "installing Apache Cassandra"

sudo bash -c 'cat <<EOF > /etc/yum.repos.d/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
EOF'
sudo yum -y check-update
sudo yum -y install cassandra

sudo iptables -I INPUT 1 -p tcp --dport 9042 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 7000 -j ACCEPT

echo "Done - installing Cassandra..."