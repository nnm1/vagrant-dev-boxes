#!/usr/bin/env bash
# Bootstrap file for setting Go development environment.

# Enable non-interactive mode.
export DEBIAN_FRONTEND=noninteractive

# Set software versions.
GO_VERSION='1.9.1' \
MONGO_VERSION='3.4' \
NODE_VERSION='8.x'

# Set locale and timezone.
sudo locale-gen ru_RU.UTF-8 \
&& sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
&& sudo timedatectl set-timezone Europe/Moscow

# Install dependencies.
sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends \
  curl \
  software-properties-common

# Install Git.
sudo add-apt-repository ppa:git-core/ppa \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends git

# Install Go and set env variables.
curl -sL https://storage.googleapis.com/golang/go"$GO_VERSION".linux-amd64.tar.gz | \
  sudo tar -xz -C /usr/local \
&& echo 'export GOROOT=/usr/local/go' | tee -a ~/.profile \
&& echo 'export GOPATH=/vagrant/code' | tee -a ~/.profile \
&& echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' | tee -a ~/.profile \
&& source ~/.profile

# Install MongoDB.
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
&& echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/$MONGO_VERSION multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-"$MONGO_VERSION".list \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends mongodb-org

# Start mongod for the current session
# and wait 5 seconds to ensure the service is running.
sudo systemctl start mongod \
&& sleep 5

# Enable Mongo authentication.
mongo admin \
  --eval "db.createUser({ user: 'vagrant', pwd: 'vagrant', roles: [{ role: 'userAdminAnyDatabase', db: 'admin' }] })" \
&& sudo sed -i 's/#security:/security:\n  authorization: enabled/g' \
  /etc/mongod.conf

# Allow the remote connections.
# USE FOR DEV MODE ONLY!
sudo sed -i 's/  bindIp: 127.0.0.1/#  bindIp: 127.0.0.1/g' /etc/mongod.conf

# Restart mongod to enable auth and start the service automatically at boot.
sudo systemctl restart mongod
sudo systemctl enable mongod

# Install NodeJS and set Npm permissions.
curl -sL https://deb.nodesource.com/setup_"$NODE_VERSION" | sudo bash - \
&& sudo apt-get install -y --no-install-recommends nodejs \
&& mkdir ~/.npm-global \
&& npm config set prefix '~/.npm-global' \
&& echo 'export PATH=~/.npm-global/bin:$PATH' | tee -a ~/.profile \
&& source ~/.profile

# Update Npm.
npm install --global npm

echo 'All set, rock on!'
