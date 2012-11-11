name             "myface"
maintainer       "Sean OMeara"
maintainer_email "someara@opscode.com"
license          "Apache2"
description      "Installs/Configures myface"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.1"

depends "yum"
depends "apache2"
depends "database"
depends "php"

