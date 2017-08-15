# java-postgres-box

A Vagrant-powered virtual machine for Java application development.

Default PostgreSQL port 5432 in the host computer is forwarded to port 5432 in the virtual machine.

Port 8000 in the host computer is also forwarded to port 8000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:8000 in the host computer.

## What's In The Box

* PostgreSQL 9.6 with 'postgres:vagrant' superuser

* Java 8

* NodeJS 6.x LTS with Npm and the latest stable Yarn

* The latest stable Git
