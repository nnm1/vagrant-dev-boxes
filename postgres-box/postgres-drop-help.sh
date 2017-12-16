#!/usr/bin/env bash
# Print commands to drop PostgreSQL db and user.

echo 'Drop PostgreSQL database:'
echo 'postgres=# DROP DATABASE IF EXISTS <db_name>;'
echo ''

echo 'Drop PostgreSQL user:'
echo "postgres=# DROP USER IF EXISTS <user_name>"
echo ''

echo 'Exit psql:'
echo 'postgres=# \q'
echo ''
