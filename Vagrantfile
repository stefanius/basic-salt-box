# Ubuntu Cloud image already contains guest additions, which are out of date,
# uninstall them and let the vbguest plugin handle this
class CloudUbuntuVagrant < VagrantVbguest::Installers::Ubuntu
  def install(opts=nil, &block)
    communicate.sudo("apt-get -y -q remove --purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11", opts, &block)
    @vb_uninstalled = true
    super
  end

  def running?(opts=nil, &block)
    return false if @vb_uninstalled
    super
  end
end


Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "trusty64"

  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network :private_network, ip: "192.168.33.90"
  ## For masterless, mount your file roots file root
  config.vm.synced_folder "salt/roots/", "/srv/"

  config.vm.synced_folder "sites/", "/home/vagrant/sites/", :nfs => false,
      owner: "vagrant",
      group: "www-data",
      mount_options: ["dmode=775,fmode=664"]

  ## Set your salt configs here
  config.vm.provision :salt do |salt|

    ## Minion config is set to ``file_client: local`` for masterless
    salt.minion_config = "salt/minion"

    salt.colorize = true

        salt.pillar({
          "mysql" => {
            "server" => {
                "root_password" => "false",
                "mysqld" => {
                    "bind-address" => "127.0.0.1",
                    "port" => "3307"
                },
                "user" => {
                    "0" => {
                        "name" => "frank",
                        "password" => "somepass",
                        "host" => "localhost"
                    }
                }
            }
          }
        })

    salt.verbose = true
    salt.log_level = "all"
    salt.run_highstate = true
  end
end
