name              'chef-update'
maintainer        'Reason'
maintainer_email  'reason@exratione.com'
license           'MIT'
description       'Update the version of Chef present on the server.'
version           '0.0.1'
recipe            'chef-update', 'Update the version of Chef.'

%w{ redhat centos suse scientific fedora debian ubuntu arch freebsd amazon }.each do |os|
  supports os
end
