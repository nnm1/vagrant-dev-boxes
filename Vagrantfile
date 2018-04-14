# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'bento/ubuntu-16.04'

  # Forward ports.
  # config.vm.network 'forwarded_port', guest: 3000, host: 3000 # Rails.
  # config.vm.network 'forwarded_port', guest: 5432, host: 5432 # Postgres.
  # config.vm.network 'forwarded_port', guest: 8000, host: 8000 # Spring, Laravel and Django.
  # config.vm.network 'forwarded_port', guest: 27017, host: 27017 # Mongo.

  # Use private network (required by NFS).
  config.vm.network 'private_network', type: 'dhcp'

  # Customize the VM.
  config.vm.provider 'virtualbox' do |v|
    # Allow symlinks on shared folders.
    v.customize ['setextradata', :id, 'VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root', '1']

    v.cpus = 1 # Use one processor.
    v.memory = 1024 # Use 1024 of RAM.
  end

  # Install required software.
  config.vm.provision 'shell', path: 'bootstrap.sh', privileged: false, keep_color: true

  # Enable NFS to speed up folders sharing.
  config.vm.synced_folder '.', '/vagrant', type: 'nfs'
end
