#!/bin/sh

set -e

mkdir -p $STI_SCRIPTS_PATH $HOME

useradd default -u 1001 -g 0 -d $HOME -M
chown -R default $HOME

SCRIPT_DIR=$(dirname "$0")
SCRIPT_DIR=`cd "$SCRIPT_DIR"; pwd`

chmod +x $SCRIPT_DIR/run $SCRIPT_DIR/assemble $SCRIPT_DIR/fix-permissions
mv $SCRIPT_DIR/run $STI_SCRIPTS_PATH
mv $SCRIPT_DIR/assemble $STI_SCRIPTS_PATH
mv $SCRIPT_DIR/fix-permissions /usr/bin

cd /opt
#wget -q http://172.18.1.249:9081/software/node/node-v13.3.0-linux-x64.tar.gz  
#tar zxf node-v13.3.0-linux-x64.tar.gz  
tar zxf $SCRIPT_DIR/node-v13.3.0-linux-x64.tar.gz -C /opt
chown -R root:root /opt/node-v13.3.0-linux-x64 
mv /opt/node-v13.3.0-linux-x64  /opt/node-v13.3.0

rm -fr "$SCRIPT_DIR"
