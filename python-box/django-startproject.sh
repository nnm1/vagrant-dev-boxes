#!/usr/bin/env bash
# Init a local virtualenv and create a Django project.

if [ "$#" -ne 1 ]; then
  echo 'Illegal number of parameters: pass <projectname>'
  exit 1
fi

# Create dir for project
echo 'Creating dir for project...'
mkdir "$1"
cd "$1"

# Init project virtualenv
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # Get script dir
source "$DIR/venv-init.sh"

mkdir src
cd src

echo 'Installing Django...'
pip3 install django psycopg2
echo 'Creating Django project...'
django-admin startproject "$1" . \
  --template https://github.com/skanukov/django-project-template/archive/master.zip \
  --extension json
