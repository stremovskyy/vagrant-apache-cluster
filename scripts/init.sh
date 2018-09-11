#!/bin/bash

echo "installing JDK ..."

su -c "yum -y install java-1.8.0-openjdk-devel"

#disabling iptables
# su -c "/etc/init.d/iptables stop"

# chmod scripts
sudo chmod u+x /vagrant/scripts/*.sh