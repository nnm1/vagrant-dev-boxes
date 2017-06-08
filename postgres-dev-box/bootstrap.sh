#!/usr/bin/env bash
# Bootstrap file for setting PostgreSQL development environment.

# Enable non-interactive mode.
export DEBIAN_FRONTEND=noninteractive \

    # Set software versions.
    POSTGRESQL_VERSION='9.6' \

# Set locale and timezone.
sudo locale-gen ru_RU.UTF-8 \
&& sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
&& sudo timedatectl set-timezone Europe/Moscow

# Install dependencies.
sudo apt-get update -qq \
&& sudo apt-get install -y --no-install-recommends \
    software-properties-common \
    wget

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

# Allow external connections for Postgresql.
echo 'host all all all password' | \
    sudo tee -a /etc/postgresql/"$POSTGRESQL_VERSION"/main/pg_hba.conf \
&& sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" \
    /etc/postgresql/"$POSTGRESQL_VERSION"/main/postgresql.conf

echo 'All set, rock on!'
