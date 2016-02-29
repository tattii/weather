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

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y python-dev
    sudo apt-get install -y python-pip
    sudo apt-get install -y cmake
    sudo apt-get install -y vim

    # jupyter
    sudo pip install jupyter
    sudo pip install ipython
    sudo mkdir /vagrant/notebook

    # Matplotlib Basemap Toolkit
    sudo apt-get install -y python-matplotlib
    sudo apt-get install -y python-mpltoolkits.basemap

    # add-apt-repository
    sudo apt-get install -y apt-file
    sudo apt-file update
    sudo apt-file search add-apt-repository
    sudo apt-get install -y software-properties-common

    # GDAL
    sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable && sudo apt-get update
    sudo apt-get install -y gdal-bin

    # NetCDF4
    sudo apt-get install -y libhdf5-serial-dev
    sudo apt-get install -y libnetcdf*
    sudo pip install NetCDF4

    # Python Grib-API
    sudo apt-get install -y libjasper-dev
    cd
    wget https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.14.5-Source.tar.gz
    tar xzf grib_api-1.14.5-Source.tar.gz
    mkdir build
    cd build
    cmake ../grib_api-1.14.5-Source
    make
    sudo make install
    # copy python modules
    sudo cp /usr/local/lib/python2.7/site-packages/grib_api/gribapi.py /usr/lib/pymodules/python2.7/
    sudo cp /usr/local/lib/python2.7/site-packages/grib_api/gribapi_swig.py /usr/lib/pymodules/python2.7/
    sudo cp /usr/local/lib/python2.7/site-packages/grib_api/_gribapi_swig.so /usr/lib/pymodules/python2.7/

    # pygrib
    sudo apt-get install -y python-grib
    sudo pip install metpy

  SHELL

  config.vm.provision "shell", run: "always", inline: <<-SHELL
    jupyter notebook --notebook-dir=/vagrant/notebook --no-browser --ip=0.0.0.0 &
  SHELL

end
