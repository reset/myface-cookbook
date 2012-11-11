require 'berkshelf/vagrant'

Vagrant::Config.run do |config|

  config.vm.define :myface_web do |myface_web|
    myface_web.vm.host_name = "myface"
    myface_web.vm.box = "opscode-centos-6.3"
    myface_web.vm.network :hostonly, "33.33.33.10"
    myface_web.ssh.max_tries = 40
    myface_web.ssh.timeout   = 120
    
    config.vm.provision :chef_solo do |chef|
      chef.json = {
        :mysql => {
          :server_root_password => 'rootpass',
          :server_debian_password => 'debpass',
          :server_repl_password => 'replpass'
        }
      }      
      chef.run_list = [ "recipe[myface::default]" ]
    end
  end
  
end
