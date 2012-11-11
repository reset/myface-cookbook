name             "myface-cookbook"
maintainer       "Sean OMeara"
maintainer_email "someara@opscode.com"
license          "Apache2"
description      "Installs/Configures myface-cookbook"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.1"

depends "yum"
depends "apache2"
depends "database"



