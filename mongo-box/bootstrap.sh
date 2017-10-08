#!/usr/bin/env bash
# Bootstrap file for setting Mongo development environment.

# Enable non-interactive mode.
export DEBIAN_FRONTEND=noninteractive

# Set software versions.
MONGO_VERSION='3.4'

# Set locale and timezone.
sudo locale-gen ru_RU.UTF-8 \
&& sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
&& sudo timedatectl set-timezone Europe/Moscow

# Install dependencies.
sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends \
  software-properties-common

# Install MongoDB.
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
&& echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/$MONGO_VERSION multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-"$MONGO_VERSION".list \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends mongodb-org

# Start mongod for the current session
# and wait 5 seconds to ensure the service is running.
sudo systemctl start mongod.service \
&& sleep 5

# Enable Mongo authentication.
mongo admin \
  --eval "db.createUser({ user: 'vagrant', pwd: 'vagrant', roles: [{ role: 'userAdminAnyDatabase', db: 'admin' }] })" \
&& sudo sed -i "s/#security:/security:\n  authorization: enabled/g" \
  /etc/mongod.conf

# Restart mongod to enable auth and start the service automatically at boot.
sudo systemctl restart mongod.service
sudo systemctl enable mongod.service

echo 'All set, rock on!'
