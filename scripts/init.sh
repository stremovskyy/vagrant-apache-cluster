#!/bin/bash

echo "installing JDK ..."

if [ ! -f  $TARGET/$JAVA_NAME.rpm ]; then
    echo "downloading java"
    mkdir -p $TARGET
    chown vagrant:vagrant $TARGET
    BASE_URL="technetwork/java/javase/downloads"
    BASE_URL_OUTPUT="$(curl -s  -L0 http://www.oracle.com/${BASE_URL}/)"
    JAVA_ENVIRONMENT="JDK"
    JAVA_BASE_VERSION=8
    DOWNLOAD_SITE="$(echo $BASE_URL_OUTPUT | grep -m 1 -io "${JAVA_ENVIRONMENT}${JAVA_BASE_VERSION}-downloads-[0-9]*.html" -- | tail -1)"
    echo "DOWNLOAD_SITE="$DOWNLOAD_SITE
    DOWNLOAD_LINK_OUTPUT="$(curl -s -L -j -H "Cookie: oraclelicense=accept-securebackup-cookie" http://www.oracle.com/${BASE_URL}/${DOWNLOAD_SITE} |  grep -io "filepath.*${JAVA_ENVIRONMENT}-[${JAVA_BASE_VERSION}].*linux[-_]x64[._].*\(rpm\)" -- | cut -d '"' -f 3 | tail -1)"
    echo "DOWNLOAD_LINK_OUTPUT="$DOWNLOAD_LINK_OUTPUT
    curl -L -o $TARGET/$JAVA_NAME.rpm -b "oraclelicense=a" $DOWNLOAD_LINK_OUTPUT
fi

if [ -f $TARGET/$JAVA_NAME.rpm ]; then 
   yum localinstall -y $TARGET/$JAVA_NAME.rpm
fi

#disabling iptables
# su -c "/etc/init.d/iptables stop"

# chmod scripts
sudo chmod u+x /vagrant/scripts/*.sh