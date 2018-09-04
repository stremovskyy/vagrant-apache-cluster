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
sudo yum check-update
sudo yum -y install cassandra

echo "Done - installing Cassandra..."