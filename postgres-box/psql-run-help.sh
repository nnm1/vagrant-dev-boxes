#!/usr/bin/env bash
# Prints command to run psql for a non-root user.

echo 'psql -h localhost -d <db_name> -U <user_name>'
