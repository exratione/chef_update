#
# Ensure that Chef is updated.
#

# Go get the opscode chef install script.
file '/tmp/opscode-chef-install.sh' do
  backup false
  action :delete
end
remote_file '/tmp/opscode-chef-install.sh' do
  source 'https://www.opscode.com/chef/install.sh'
  mode 0744
  backup false
  action :create
end

execute 'Run Opscode Chef install script' do
  command '/tmp/opscode-chef-install.sh'
end
