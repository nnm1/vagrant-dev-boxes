#!/usr/bin/env bash
# Print commands to create PostgreSQL db, user and to grant privileges.

echo 'Create PostgreSQL database:'
echo 'postgres=# CREATE DATABASE db_name;'

echo 'Create PostgreSQL user:'
echo "postgres=# CREATE USER user_name WITH PASSWORD 'password';"

echo 'Grant privileges:'
echo "postgres=# GRANT ALL PRIVILEGES ON DATABASE db_name TO user_name;"

sudo -u postgres psql
