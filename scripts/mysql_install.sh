#!/bin/bash

echo "MySQL Cluster: - Installing..."

sudo rpm -i https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
sudo yum -y install yum-utils
sudo yum-config-manager  -y --disable mysql80-community
sudo yum-config-manager  -y --enable mysql57-community
sudo yum  -y repolist
sudo yum  -y install mysql-community-server mysql-shell policycoreutils-python mysql-router expect

sudo iptables -I INPUT 1 -p tcp --dport 3306 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 3301 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 33011 -j ACCEPT
sudo /usr/sbin/semanage port -a -t mysqld_port_t -p tcp 3301
sudo /usr/sbin/semanage port -a -t mysqld_port_t -p tcp 33011

echo "MySQL Cluster: - Installing - Done."