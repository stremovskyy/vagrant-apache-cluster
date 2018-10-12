#!/bin/bash

echo "MySQL Cluster: - Configuring..."

sudo systemctl stop mysqld

sudo tee -a /etc/my.cnf << EOL
bind-address=0.0.0.0
port=3301
# Replication part
server_id=$1
gtid_mode=ON
enforce_gtid_consistency=ON
master_info_repository=TABLE
relay_log_info_repository=TABLE
binlog_checksum=NONE
log_slave_updates=ON
log_bin=binlog
binlog_format=ROW
plugin-load = group_replication.so
# Group replication part
transaction_write_set_extraction=XXHASH64
#loose-group_replication_group_name="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
loose-group_replication_start_on_boot = OFF
loose-group_replication_local_address = $NODE_IP_PREFIX$1:33011
loose-group_replication_bootstrap_group = OFF
#loose-group_replication_group_seeds= "$MYSQL_CLUSTER_NODES"
report_port = 3301
report_host = $NODE_IP_PREFIX$1

EOL

sudo rm -rf /var/lib/mysql && sudo mkdir /var/lib/mysql && sudo chown mysql:mysql /var/lib/mysql && sudo chmod 751 /var/lib/mysql
sudo systemctl start mysqld
export TEMP_MYSQL_PASSWORD="$(sudo grep 'temporary password' /var/log/mysqld.log | awk -F 'root@localhost: ' '{ print $2 }')"

expect -c "
set timeout 10
spawn mysql_secure_installation --use-default
expect \"Enter password for user root:\"
send \"$TEMP_MYSQL_PASSWORD\r\"
expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect eof"

yum -y erase expect

mysqlsh root@127.0.0.1:3301 -p$MYSQL_ROOT_PASSWORD -e "dba.configureLocalInstance('root:$MYSQL_ROOT_PASSWORD@127.0.0.1:3301', {mycnfPath: '/etc/my.cnf', clusterAdmin: 'cladmin', clusterAdminPassword: '$MYSQL_ROOT_PASSWORD'})"

echo "MySQL Cluster: - Configuring - Done."

