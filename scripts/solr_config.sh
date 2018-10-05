#!/bin/bash

echo "Configuring Apache Solr"

nohup $SOLR_NAME/bin/solr zk mkroot /solr -z $ZK_NODES &

tee -a $SOLR_NAME/security.json <<EOL
{
  "authentication":{
   "blockUnknown": false,
   "class":"solr.BasicAuthPlugin",
   "credentials":{"user":"vgGVo69YJeUg/O6AcFiowWsdyOUdqfQvOLsrpIPMCzk= 7iTnaKOWe+Uj5ZfGoKKK2G6hrcF10h6xezMQK+LBvpI="}
  },
  "authorization":{
   "class":"solr.RuleBasedAuthorizationPlugin",
   "permissions":[
 {"name":"security-edit", "role":"admin"},
 {"name":"collection-admin-edit", "role":"admin"},
 {"name":"core-admin-edit", "role":"admin"}
   ],
   "user-role":{"user":"admin"}
  }
}
EOL

sudo yum -y install lsof
nohup $SOLR_NAME/bin/solr zk cp file:$SOLR_NAME/security.json zk:/security.json -z $ZK_NODES &
nohup $SOLR_NAME/bin/solr zk cp file:$SOLR_NAME/server/solr/solr.xml  zk:/solr.xml -z $ZK_NODES &
nohup $SOLR_NAME/bin/solr create -c vagrant_index -replicationFactor 3 -shards 1 &
sudo sed -i '$ a * soft nofile 65000' /etc/security/limits.conf
sudo sed -i '$ a * hard nofile 65000' /etc/security/limits.conf
sudo sed -i '$ a * soft nproc 65000' /etc/security/limits.conf
sudo sed -i '$ a * hard nproc 65000' /etc/security/limits.conf
ulimit -u 65000
sudo sysctl -p /etc/sysctl.conf
sudo sysctl -w fs.file-max=100000
sudo sysctl --system

echo "DONE Configuring Apache Solr"