# vagrant-dev-boxes

A collection of Vagrant-powered virtual machines for application development.

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

## What's In Every Box

* Ubuntu 16.04

## Note About Symlinks

To allow guest system to create symlinks, `vagrant up` command should be run as administrator.

## License

Released under the MIT License, Copyright (c) 2017 Sergey Kanukov, inspired by official [Rails dev box](https://github.com/rails/rails-dev-box).
