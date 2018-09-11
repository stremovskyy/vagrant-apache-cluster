#!/bin/bash

echo "Configuring Apache Solr"

nohup $SOLR_NAME/bin/solr zk mkroot /solr -z $ZK_NODES &

cat > $SOLR_NAME/security.json <<EOL
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

nohup $SOLR_NAME/bin/solr zk cp file:$SOLR_NAME/security.json zk:/security.json -z $ZK_NODES &
nohup $SOLR_NAME/bin/solr zk cp file:$SOLR_NAME/server/solr/solr.xml  zk:/solr.xml -z $ZK_NODES &