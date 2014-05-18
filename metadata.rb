name              'chef_update'
maintainer        'Reason'
maintainer_email  'reason@exratione.com'
license           'MIT'
description       'Update the version of Chef present on the server.'
version           '0.0.2'
recipe            'chef_update', 'Update the version of Chef.'

%w{ redhat centos suse scientific fedora debian ubuntu arch freebsd amazon }.each do |os|
  supports os
end

attribute 'chef_update/minimum_version/major',
  :display_name => 'Minimum acceptable major version',
  :description => 'The minimum acceptable major version of Chef.',
  :default => '11'

attribute 'chef_update/minimum_version/minor',
  :display_name => 'Minimum acceptable minor version',
  :description => 'The minimum acceptable minor version of Chef.',
  :default => '6'
