Movable Type Prerequisites Cookbook
===================================

This trivial cookup is used when starting up a VM via Vagrant with chef-solo
integration to ensure that the version of Chef on the VM is updated to the
latest.

In the Vagrantfile you want to add a separate provision block in advance of
your usual provision block:

    # Ensure that we update the version of chef on the guest machine. This has
    # to be a separate provision statement issued before the real provisioning.
    config.vm.provision :chef_solo do |chef|
      chef.run_list = [
        "recipe[chef-update]"
      ]
    end

    # Enable provisioning with chef solo. Paths are relative to this project
    # directory.
    config.vm.provision :chef_solo do |chef|
      # Start the usual provisioning here.
    end
