#!/bin/bash

echo "Configuring Apache Ignite"

sed -i 's#/>#>#' $IGNITE_NAME/config/config.xml