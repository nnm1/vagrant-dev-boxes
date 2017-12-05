#!/usr/bin/env bash
# Bootstrap file for setting Go development environment.

# Enable non-interactive mode.
export DEBIAN_FRONTEND=noninteractive

# Set software versions.
GO_VERSION='1.9.2' \
POSTGRESQL_VERSION='10' \
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

# Install PostgreSQL.
echo 'deb https://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' | \
  sudo tee -a /etc/apt/sources.list.d/pgdg.list \
&& curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add - \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends \
  postgresql-"$POSTGRESQL_VERSION" \
  postgresql-contrib-"$POSTGRESQL_VERSION" \
  libpq-dev

# Set 'postgres' user password (USE FOR DEV MODE ONLY!).
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'vagrant';"

# Allow external connections for PostgreSQL (USE FOR DEV MODE ONLY!).
echo 'host all all all md5' | \
  sudo tee -a /etc/postgresql/"$POSTGRESQL_VERSION"/main/pg_hba.conf \
&& sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" \
  /etc/postgresql/"$POSTGRESQL_VERSION"/main/postgresql.conf

# Restart the PostgreSQL server for the changes to take effect.
sudo service postgresql restart

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
