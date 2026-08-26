#!/bin/bash

set -e

echo "start to install node for nologin and no-home-path-user."

NODE_VERSION=v24.10.0
ARCH=x64

sudo mkdir -p /usr/local/src/node_installation
cd /usr/local/src/node_installation

sudo curl -fsSLO https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-${ARCH}.tar.xz
sudo curl -fsSLO https://nodejs.org/dist/${NODE_VERSION}/SHASUMS256.txt

grep node-${NODE_VERSION}-linux-${ARCH}.tar.xz SHASUMS256.txt | sha256sum -c -

sudo tar -C /opt -xJf node-${NODE_VERSION}-linux-${ARCH}.tar.xz

sudo ln -sfn /opt/node-${NODE_VERSION}-linux-${ARCH} /opt/node

sudo chown -R root:root /opt/node/
sudo chmod -R a+rX /opt/node/

sudo ln -s /opt/node/bin/node /usr/local/bin/node
sudo ln -s /opt/node/bin/npm /usr/local/bin/npm
sudo ln -s /opt/node/bin/npx /usr/local/bin/npx

node -v
npm -v
npx -v

sudo /opt/node/bin/npm install -g pm2
echo "1.maybe you can add "export PATH=/opt/node/bin:$PATH" in /etc/environment or /etc/profile, then source /etc/environment make it effective."

echo "2.please remember create nologin user and /home path for it first cause npm install xxx would need it."

echo "3.check your pm2 installation and version."

echo "done"
