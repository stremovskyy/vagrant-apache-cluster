#!/bin/bash

echo "hosts file setup..."

# sudo echo "10.30.3.30 br1" | sudo tee -a /etc/hosts
# sudo echo "10.30.3.20 br2" | sudo tee -a /etc/hosts
# sudo echo "10.30.3.10 br3" | sudo tee -a /etc/hosts

sudo echo "192.168.1.210 br1" | sudo tee -a /etc/hosts
sudo echo "192.168.1.220 br2" | sudo tee -a /etc/hosts
sudo echo "192.168.1.230 br3" | sudo tee -a /etc/hosts