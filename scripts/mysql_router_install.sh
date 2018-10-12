#!/bin/bash

echo "MySQL Router: - Installing..."

echo $MYSQL_ROOT_PASSWORD | sudo mysqlrouter --bootstrap $NODE_IP_PREFIX"1":3301 --user mysqlrouter
sudo sed -i 's/6446/3306/' /etc/mysqlrouter/mysqlrouter.conf
sudo sed -i 's/6447/3307/' /etc/mysqlrouter/mysqlrouter.conf
sudo systemctl start mysqlrouter