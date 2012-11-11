#
# Cookbook Name:: myface-cookbook
# Recipe:: default
#
# Copyright (C) 2012 Opscode
# :: Author Sean OMeara <someara@opscode.com>
# 
# Apache2 license
#

######################
# webserver section
######################

include_recipe "apache2"
include_recipe "apache2::mod_php5"

# disable default site
apache_site "000-default" do
  enable false
end

# create apache config
template "#{node['apache']['dir']}/sites-available/myface.conf" do
  source "apache2.conf.erb"
  notifies :restart, 'service[apache2]'
end

# create document root
directory  "/srv/apache/myface" do
  action :create
  recursive true
end

# write siteX
template "/srv/apache/myface/index.php" do
  source "index.php.erb"
  mode "0644" # forget me to create debuging exercise
end

# enable myface
apache_site "myface.conf" do
  enable true
end

######################
# database section
######################


include_recipe "mysql::server"
include_recipe "mysql::ruby"

#chef_gem "mysql"

mysql_database 'myface' do
  connection ({
      :host => "localhost",
      :username => 'root',
      :password => node['mysql']['server_root_password']
    })
  action :create
end

cookbook_file "/tmp/myface-init.sql" do
  source "myface-init.sql"
  owner "root"
  mode "644"
end

execute "initialize myface database" do
  command "mysql -h localhost -u root -p#{node['mysql']['server_root_password']} -D myface < /tmp/myface-init.sql"
  not_if "mysql -h localhost -u root -p#{node['mysql']['server_root_password']} -D myface -e 'describe users;'"
end

