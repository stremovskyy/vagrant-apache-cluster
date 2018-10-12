#!/bin/bash

echo "MySQL Cluster: - Configuring node..."

echo "set GLOBAL group_replication_allow_local_disjoint_gtids_join=ON;" | mysql -P 3301 -u root -p$MYSQL_ROOT_PASSWORD
echo y | sudo mysqlsh cladmin@$NODE_IP_PREFIX$1:3301 -p$MYSQL_ROOT_PASSWORD -e "dba.configureLocalInstance()"
mysqlsh cladmin@"$NODE_IP_PREFIX"1:3301 -p$MYSQL_ROOT_PASSWORD --cluster -e "cluster.addInstance('cladmin:$MYSQL_ROOT_PASSWORD@$NODE_IP_PREFIX$1:3301')"
echo y | sudo mysqlsh cladmin@$NODE_IP_PREFIX$1:3301 -p$MYSQL_ROOT_PASSWORD -e "dba.configureLocalInstance()"

