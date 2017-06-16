#!/usr/bin/env bash
# Create a Django app.

if [ "$#" -ne 1 ]; then
  echo 'Illegal number of parameters: pass <appname>'
  exit 1
fi

echo 'Creating Django app...'
django-admin startapp "$1" \
  --template https://github.com/skanukov/django-app-template/archive/master.zip \
  --extension js
