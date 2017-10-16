# python-postgres-box

A Vagrant-powered virtual machine for Python application development.

Default PostgreSQL port 5432 in the host computer is forwarded to port 5432 in the virtual machine.

Port 8000 in the host computer is also forwarded to port 8000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:8000 in the host computer. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1, so it can access all interfaces, e.g.:

    $ python3 manage.py runserver 0.0.0.0:8000

## What's In The Box

* PostgreSQL 10.0 with 'postgres:vagrant' superuser

* Python 3.6 and the latest stable pip3 with installed virtualenv

* NodeJS 8.x LTS with Npm

* The latest stable Git
