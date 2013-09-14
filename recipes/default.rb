#
# Ensure that Chef is updated.
#

# Check the current Chef version.
#
# Return true if it is at least as recent as the provided major.minor values.
def version_sufficient(major, minor)
  major = Integer(major)
  minor = Integer(minor)
  currentMajor = Chef::Version.new(Chef::VERSION).major;
  currentMinor = Chef::Version.new(Chef::VERSION).minor;
  if currentMajor < major
    return false
  elsif currentMajor == major && currentMinor < minor
    return false;
  else
    return true;
  end
end

if !version_sufficient(node[:chef_update][:minimum_version][:major], node[:chef_update][:minimum_version][:minor])
  # Go get the opscode chef install script.
  remote_file '/tmp/opscode-chef-install.sh' do
    source 'https://www.opscode.com/chef/install.sh'
    mode 0744
    backup false
    action :create
  end
  # And run it. This is only good for supported Unix variants.
  execute 'Run Opscode Chef install script' do
    command '/tmp/opscode-chef-install.sh'
  end
end
