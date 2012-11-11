#
# Cookbook Name:: myface-cookbook
# Recipe:: default
#
# Copyright (C) 2012 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

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

# include_recipe "mysql::server"

