# vagrant-dev-boxes

A Vagrant-powered virtual machine for application development.

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

### Install Vagrant NFS plugin for Windows

    host $ vagrant plugin install vagrant-winnfsd

### Install NFS for Linux

    host $ sudo apt-get install nfs-kernel-server

## How To Build The Virtual Machine

Building the virtual machines is this easy:

    host $ git clone https://github.com/skanukov/vagrant-dev-boxes
    host $ cd vagrant-dev-boxes/<box>
    host $ vagrant up

That's it.

After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh

Don't forget to look at some helper shell scripts for newbies.

## What's In The Box

* Ubuntu 16.04

* The latest stable Git

## Available Software

* Go 1.9

* Java 9

* MariaDB 10.2 with 'root:vagrant' superuser

* MongoDB 3.6 with 'vagrant:vagrant' superuser

* NodeJS 8.x LTS with Npm

* PHP 7.2 with the latest stable Composer

* PostgreSQL 10 with 'postgres:vagrant' superuser

* Python 3.6 and the latest stable pip3 with installed virtualenv

* Ruby 2.4 with disabled automatic documentation

Remember to map database and application ports in the host computer to ports in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:xxxx in the host computer. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1 so it can access all interfaces, e.g.:

    $ php artisan serve --host=0.0.0.0
    $ python3 manage.py runserver 0.0.0.0:8000
    $ bin/rails server -b 0.0.0.0

## Notes

* To allow guest system to create symlinks, `vagrant up` command should be run as administrator.

* If bash can not connect to the guest system, try `VAGRANT_PREFER_SYSTEM_BIN=1 vagrant ssh`

## License

Released under the MIT License, Copyright (c) 2017 Sergey Kanukov, inspired by official [Rails dev box](https://github.com/rails/rails-dev-box).
