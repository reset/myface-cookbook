#
# Cookbook Name:: myface-cookbook
# Recipe:: database
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

include_recipe "mysql::server"
include_recipe "mysql::ruby"
include_recipe "php::module_mysql"

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

