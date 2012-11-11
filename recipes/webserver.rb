#
# Cookbook Name:: myface-cookbook
# Recipe:: webserver
#
# Copyright 2008-2009, Opscode, Inc.
# Author:: Sean OMeara <someara@opscode.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
