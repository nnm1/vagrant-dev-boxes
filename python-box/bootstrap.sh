#!/usr/bin/env bash
# Bootstrap file for setting Python development environment.

# Enable non-interactive mode.
export DEBIAN_FRONTEND=noninteractive

# Set software versions.
PYTHON_VERSION='3.6' \
POSTGRESQL_VERSION='9.6' \
NODE_VERSION='8.x'

# Set locale and timezone.
sudo locale-gen ru_RU.UTF-8 \
&& sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
&& sudo timedatectl set-timezone Europe/Moscow

# Install dependencies.
sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends \
  build-essential \
  gettext \
  software-properties-common \
  wget

# Install Git.
sudo add-apt-repository ppa:git-core/ppa \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends git

# Install Python3.
sudo add-apt-repository ppa:jonathonf/python-"$PYTHON_VERSION" \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends \
  python"$PYTHON_VERSION" \
  python"$PYTHON_VERSION"-dev

# Set Python3 aliases.
echo "alias python3=python$PYTHON_VERSION" | tee -a ~/.bash_aliases \
&& source ~/.bash_aliases

# Install Pip3 (autoset Pip3 aliases).
wget -qO- https://bootstrap.pypa.io/get-pip.py | sudo python"$PYTHON_VERSION"

# Install virtualenv.
sudo pip3 install virtualenv

# Install PostgreSQL.
echo 'deb https://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' | \
  sudo tee -a /etc/apt/sources.list.d/pgdg.list \
&& wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add - \
&& sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends \
  postgresql-"$POSTGRESQL_VERSION" \
  postgresql-contrib-"$POSTGRESQL_VERSION" \
  libpq-dev

# Set 'postgres' user password.
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'vagrant';"

# Allow external connections for PostgreSQL.
echo 'host all all all md5' | \
  sudo tee -a /etc/postgresql/"$POSTGRESQL_VERSION"/main/pg_hba.conf \
&& sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" \
  /etc/postgresql/"$POSTGRESQL_VERSION"/main/postgresql.conf

# Restart the PostgreSQL server for the changes to take effect.
sudo service postgresql restart

# Install NodeJS and set Npm permissions.
wget -qO- https://deb.nodesource.com/setup_"$NODE_VERSION" | sudo bash - \
&& sudo apt-get install -y --no-install-recommends nodejs \
&& mkdir ~/.npm-global \
&& npm config set prefix '~/.npm-global' \
&& echo 'export PATH=~/.npm-global/bin:$PATH' | tee -a ~/.profile \
&& source ~/.profile

echo 'All set, rock on!'
