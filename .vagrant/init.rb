# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder HOST_SRC_DIR, GUEST_SRC_DIR, owner: "www-data", group: "www-data" 
  
  config.vm.box = BOX_IMAGE_NAME
  config.vm.network "private_network", ip: BIND_IP_ADDRESS
  config.ssh.insert_key = false

if INSTALL_COMMON_TOOLS
  config.vm.provision :shell do |s|
    s.path = SCRIPTS_DIR + "/install_common_tools.sh"
    s.args = [HOSTNAME, GUEST_SRC_DIR]
  end
end

  if INSTALL_PHP
    config.vm.provision :shell, path: SCRIPTS_DIR + "/install_phpfpm.sh" 
  end

  if INSTALL_NGINX
    config.vm.provision "file", source: ".vagrant/app.template", destination: "/tmp/app.template"
    config.vm.provision :shell do |s|
      s.path = SCRIPTS_DIR + "/install_nginx.sh"
      s.args = [HOSTNAME, GUEST_SRC_DIR]
    end
  end

  if  INSTALL_NODEJS
    config.vm.provision :shell, path: SCRIPTS_DIR + "/install_nodejs.sh"
  end

  if INSTALL_MARIADB
    config.vm.provision :shell do |s|
      s.path = SCRIPTS_DIR + "/install_mariadb.sh"
      s.args = [MARIADB_USER,  MARIADB_PASSWORD]
    end
  end

end
