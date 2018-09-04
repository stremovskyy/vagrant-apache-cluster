#!/bin/bash

echo "installing Apache Ignite"
su -c "sudo bash -c 'cat <<EOF > /etc/yum.repos.d/ignite.repo
[base]
name=Apache Ignite
baseurl=https://apache.org/dist/ignite/rpm/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://apache.org/dist/ignite/KEYS
https://bintray.com/user/downloadSubjectPublicKey?username=bintray
EOF'"

su -c "sudo yum check-update && sudo yum install apache-ignite"