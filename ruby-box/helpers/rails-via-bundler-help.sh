#!/usr/bin/env bash
# Init Rails app via the Bundler.

echo 'Use following commands to init new Rails app via Bundler:'
echo '$ mkdir app_name'
echo '$ cd app_name'
echo '$ bundle init'
echo ''

echo 'Specify required Rails version in Gemfile, i.g.:'
echo "gem 'rails', '~> 5.1'"
echo 'Save the file and execute:'
echo '$ bundle install --path vendor/bundle'
echo 'Confirm to rewrite Gemfile'
echo ''

echo 'After bundle installs required gems create Rails app:'
echo '$ bundle exec rails new . --database=postgresql'
echo "That's it! You can now execute Rails commands via prefexing 'bin' dir:"
echo '$ bin/rails s -b 0.0.0.0'
echo ''

echo "Don't forget to add '/vendor/bundle' dir to your .gitignore file"
echo ''
