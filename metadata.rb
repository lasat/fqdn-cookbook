name             'fqdn'
maintainer       'Sean OMeara'
maintainer_email 'someara@chef.io'
license          'Apache2'
description      'Installs/Configures fqdn'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.2'

depends 'line'
depends 'hostsfile'
depends 'now'
