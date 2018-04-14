# vagrant-dev-boxes

A Vagrant-powered virtual machine for application development.

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

### Install Vagrant NFS plugin for Windows

    host $ vagrant plugin install vagrant-winnfsd

### Install NFS for Linux

    host $ sudo apt-get install nfs-kernel-server

## What's In The Box

* Ubuntu 16.04

## Available Software

* Go 1.10

* Java 8 LTS

* MariaDB 10.2 with 'root:vagrant' superuser

* MongoDB 3.6 with 'vagrant:vagrant' superuser

* NodeJS 8.x LTS with Npm

* PHP 7.2 with the latest stable Composer

* PostgreSQL 10 with 'postgres:vagrant' superuser

* Python 3.6 and the latest stable pip3 with installed virtualenv

* Ruby 2.5 with disabled automatic documentation

Remember to map database and application ports in the host computer to ports in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:xxxx in the host computer. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1 so it can access all interfaces, e.g.:

    $ php artisan serve --host=0.0.0.0
    $ python3 manage.py runserver 0.0.0.0:8000
    $ bin/rails server -b 0.0.0.0

Don't forget to look at some helper shell scripts for newbies.

## Notes

* To allow guest system to create symlinks, disable NFS syncing and run `vagrant up` command as administrator.

* If a shell can not connect to the guest system, try `VAGRANT_PREFER_SYSTEM_BIN=1 vagrant ssh`
