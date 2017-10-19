#!/usr/bin/env bash
# Bootstrap file for setting PHP development environment.

# Enable non-interactive mode.
export DEBIAN_FRONTEND=noninteractive

# Set software versions.
PHP_VERSION='7.1' \
MARIADB_VERSION='10.2' \
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

# Install PHP.
sudo add-apt-repository ppa:ondrej/php \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends \
  php"$PHP_VERSION" \
  php"$PHP_VERSION"-mbstring \
  php"$PHP_VERSION"-mysql \
  php"$PHP_VERSION"-xml \
  php"$PHP_VERSION"-zip # Laravel dependencies.

# Install Composer.
curl -sL https://getcomposer.org/installer | \
  sudo php -- --install-dir=/usr/local/bin --filename=composer

# Set MariaDB root password.
sudo debconf-set-selections <<< \
  'mysql-server mysql-server/root_password password vagrant' \
&& sudo debconf-set-selections <<< \
  'mysql-server mysql-server/root_password_again password vagrant'

# Install MariaDB.
sudo apt-key adv \
  --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 \
&& sudo add-apt-repository \
  "deb [arch=amd64,i386,ppc64el] http://mirror.mephi.ru/mariadb/repo/$MARIADB_VERSION/ubuntu xenial main" \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends mariadb-server

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
