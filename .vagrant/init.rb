# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder HOST_SRC_DIR, GUEST_SRC_DIR, owner: "www-data", group: "www-data" 
  
  config.vm.box = BOX_IMAGE_NAME
  config.vm.network "private_network", ip: BIND_IP_ADDRESS
  config.ssh.insert_key = false
  
  # install common tools
  config.vm.provision :shell do |s|
    s.path = SCRIPTS_DIR + "/install_common_tools.sh"
    s.args = [HOSTNAME, GUEST_SRC_DIR]
  end

  # php-fpm 7.4 + composer
  config.vm.provision :shell, path: SCRIPTS_DIR + "/install_phpfpm.sh" 
  
  # nginx
  config.vm.provision "file", source: ".vagrant/app.template", destination: "/tmp/app.template"
  config.vm.provision :shell do |s|
    s.path = SCRIPTS_DIR + "/install_nginx.sh"
    s.args = [HOSTNAME, GUEST_SRC_DIR]
  end
  
  # nodejs
  config.vm.provision :shell, path: SCRIPTS_DIR + "/install_nodejs.sh"
  
  # mariadb
  config.vm.provision :shell do |s|
    s.path = SCRIPTS_DIR + "/install_mariadb.sh"
    s.args = [MARIADB_USER,  MARIADB_PASSWORD]
  end

end
