#!/usr/bin/env bash
# Print commands to create MySQL db, user and to grant privileges.

echo 'Create MySQL database:'
echo 'mysql> CREATE DATABASE db_name CHARACTER SET UTF8;'
echo ''

echo 'Create MySQL user:'
echo "mysql> CREATE USER 'user_name'@'localhost' IDENTIFIED BY 'password';"
echo ''

echo 'Grant privileges:'
echo "mysql> GRANT ALL PRIVILEGES ON db_name.* TO 'user_name'@'localhost';"
echo 'mysql> FLUSH PRIVILEGES;'
echo ''

echo 'Exit mysql:'
echo 'mysql> EXIT;'
echo ''

mysql -u root -p
