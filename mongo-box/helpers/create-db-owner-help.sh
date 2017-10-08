#!/usr/bin/env bash
# Prints commands to create a Mongo db owner.

echo "Create 'test:test' db owner for the 'test' database:"
echo $"mongo test --authenticationDatabase \"admin\" -u \"vagrant\" -p \"vagrant\" --eval \"db.createUser({ user: 'test', pwd: 'test', roles: [{ role: 'dbOwner', db: 'test' }] })\""
