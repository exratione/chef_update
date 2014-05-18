# Chef Update Cookbook

This trivial cookbook is used when starting up a VM via Vagrant with chef-solo
integration. It ensures that the version of Chef on the VM is updated to the
latest available version if it is currently earlier than a given version.

Under the hood this uses the [cross-platform installation script][1] provided
by the Chef developers.

## Attributes

Specify the minimum acceptable version with attributes. If the currently
installed version on the VM is earlier, then the latest version will be
downloaded from Opscode and installed.

  * `node['chef_update']['minimum_version']['major']`
  * `node['chef_update']['minimum_version']['minor']`

## Use With Vagrant

In the Vagrantfile you want to add a separate provision block in advance of
your usual provision block, because otherwise it won't pick up the newer version
that was just installed for the real provisioning.

```
# Update the version of chef on the guest machine. This has to be a separate
# provision statement issued before the real provisioning begins.
config.vm.provision :chef_solo do |chef|
  chef.cookbooks_path = "./cookbooks"
  chef.run_list = [
    "recipe[chef_update]"
  ]
  chef.json = {
    "chef_update" => {
      "minimum_version" => {
        "major" => 11,
        "minor" => 6
      }
    }
  }
end

# Enable provisioning with chef solo. Paths are relative to this project
# directory.
config.vm.provision :chef_solo do |chef|
  # Start the usual provisioning here.
end
```

## An Alternative Approach With Shell Provisioning

An alternative approach is to use shell provisioning rather than Chef, but this
requires you to craft something specific to your use case. For example, for a
Debian-based distribution like Ubuntu:

```
# Update the version of chef on the guest machine. This has to be a separate
# provision statement issued before the real provisioning begins.
config.vm.provision :shell, :inline => "apt-get update"
config.vm.provision :shell, :inline => "apt-get -y --no-upgrade install build-essential ruby1.9.1-dev"
config.vm.provision :shell, :inline => "gem install chef --no-rdoc --no-ri --conservative"

# Enable provisioning with chef solo. Paths are relative to this project
# directory.
config.vm.provision :chef_solo do |chef|
  # Start the usual provisioning here.
end
```

## The vagrant-omnibus Plugin is a Much Better Choice

This cookbook was thrown together as part of a learning process. A much better
approach if provisioning a Vagrant VM is to use the [vagrant-omnibus plugin][2],
not least because it can install Chef if not already present.

[1]: http://www.getchef.com/chef/install/
[2]: https://github.com/schisamo/vagrant-omnibus
