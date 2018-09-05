#!/bin/bash

echo "installing JDK and wget..."
su -c "yum -y install java-1.8.0-openjdk-devel wget"

#disabling iptables
# su -c "/etc/init.d/iptables stop"

# chmod scripts
sudo chmod u+x /vagrant/scripts/*.sh