#!/bin/bash

echo "hosts file setup..."

# sudo echo "10.30.3.30 node1" | sudo tee -a /etc/hosts
# sudo echo "10.30.3.20 node1" | sudo tee -a /etc/hosts
# sudo echo "10.30.3.10 node3" | sudo tee -a /etc/hosts

sudo echo "192.168.1.210 node1" | sudo tee -a /etc/hosts
sudo echo "192.168.1.220 node1" | sudo tee -a /etc/hosts
sudo echo "192.168.1.230 node3" | sudo tee -a /etc/hosts

