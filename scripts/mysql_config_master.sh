#!/bin/bash

echo "MySQL Cluster: - Configuring Master Node..."

echo y | sudo mysqlsh cladmin@"$NODE_IP_PREFIX"1:3301 -p$MYSQL_ROOT_PASSWORD -e "dba.checkInstanceConfiguration();cluster=dba.createCluster('VagrantCluster',  {ipWhitelist: '$CLUSTER_IPS'});dba.configureLocalInstance();cluster.status()"
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" | mysql -P 3301 -u root -p$MYSQL_ROOT_PASSWORD
