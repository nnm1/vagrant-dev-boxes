# php-postgres-box

A Vagrant-powered virtual machine for PHP application development.

Default MariaDB port 3306 in the host computer is forwarded to port 3306 in the virtual machine.

Port 8000 in the host computer is also forwarded to port 8000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:8000 in the host computer. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1, so it can access all interfaces, e.g.:

    $ php artisan serve --host=0.0.0.0

## What's In The Box

* MariaDB 10.2 with 'root:vagrant' superuser

* PHP7 7.1 with the latest stable Composer

* NodeJS 8.x LTS with Npm

* The latest stable Git
