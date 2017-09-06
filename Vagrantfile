# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "ubuntu/trusty64"
  config.vm.box = "laravel/homestead"  

  # Create a private network, which allows host-only access to the machine using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.22"

  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 5688  
  config.vm.network "forwarded_port", guest: 443, host: 5689

  #Adding aliases for different virtual host
  #config.hostmanager.enabled = true
  #config.hostmanager.manage_host = true
  #config.hostmanager.manage_guest = true
  #config.hostmanager.aliases = %w(vagrant.myproject ci.ken.dev)

  #Increase the VM memory
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end

  # config.vm.provider :virtualbox do |vb|
  #   vb.gui = true
  # end

  config.vm.boot_timeout = 200

  # Share an additional folder to the guest VM. The first argument is the path on the host to the actual folder.
  # The second argument is the path on the guest to mount the folder.
  config.vm.synced_folder "./", "/var/www/", owner:'www-data', group:'www-data'

  # Define the bootstrap file: A (shell) script that runs after first setup of your box (= provisioning)
  config.vm.provision :shell, path: "larabootstrap.sh"

end