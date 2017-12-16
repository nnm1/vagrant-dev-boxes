#!/usr/bin/env bash
# Create and activate a virtualenv.

echo 'Creating virtualenv...'
virtualenv venv --no-site-packages --always-copy # Vagrant fix.
echo 'Activating virtualenv...'
source venv/bin/activate
