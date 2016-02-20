# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  # http://datasciencetoolbox.org/
  config.vm.box = "data-science-toolbox/dst"
  config.vm.hostname = "weather"

  config.vm.network :private_network, ip:"192.168.33.11"
  #config.vm.network "forwarded_port", guest: 8888, host: 8880

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y python-dev
    sudo apt-get install -y python-pip

    # jupyter
    sudo pip install jupyter
    sudo pip install ipython
    sudo mkdir /vagrant/notebook

    # Matplotlib Basemap Toolkit
    sudo apt-get install -y python-matplotlib
    sudo apt-get install -y python-mpltoolkits.basemap

    # pygrib
    sudo apt-get install -y python-grib

    # add-apt-repository
    sudo apt-get install -y apt-file
    sudo apt-file update
    sudo apt-file search add-apt-repository
    sudo apt-get install -y software-properties-common

    # GDAL
    sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable && sudo apt-get update
    sudo apt-get install -y gdal-bin

  SHELL

  config.vm.provision "shell", run: "always", inline: <<-SHELL
    jupyter notebook --notebook-dir=/vagrant/notebook --no-browser --ip=0.0.0.0 &
  SHELL

end
