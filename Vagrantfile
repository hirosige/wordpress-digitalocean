# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.box = "bento/centos-7.3"
  config.vm.network "private_network", ip: "192.168.33.14"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/site.yml"
  end

  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    vb.memory = "1024"
  end

  config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=777']
end
