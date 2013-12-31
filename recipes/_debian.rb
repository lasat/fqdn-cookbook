#
# Cookbook Name:: fqdn
# Recipe:: debian.rb
#
# Author:: Sean OMeara
# Copyright 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


hostsfile_entry '127.0.0.1' do
  hostname node['desired_fqdn']
  aliases [
    node['desired_hostname'],
    'localhost',
    'localhost.localdomain',
    'localhost4',
    'localhost4.localdomain4'
  ]
end

hostsfile_entry '127.0.1.1' do
  hostname node['desired_fqdn']
  aliases [
    node['desired_hostname'],
    'localhost',
    'localhost.localdomain',
    'localhost4',
    'localhost4.localdomain4'
  ]
end

hostsfile_entry '::1' do
  hostname node['desired_fqdn']
  aliases [
    node['desired_hostname'],
    'localhost',
    'localhost.localdomain',
    'localhost6',
    'localhost6.localdomain6'
  ]
end

hostsfile_entry 'ff02::1' do
  hostname node['desired_fqdn']
  aliases [
    node['desired_hostname'],
    'localhost',
    'localhost.localdomain',
    'localhost6',
    'localhost6.localdomain6'
  ]
end

# needed because File::Util::FileEdit won't operate on empty or
# non-existant files. (fix that)
file '/etc/hostname' do
  action :create
  mode '00644'
  owner 'root'
  content 'localhost\n'
  not_if '/usr/bin/test -f /etc/hostname'
end

replace_or_add 'debian network hostname' do
  path '/etc/hostname'
  pattern 'localhost'
  line node['desired_hostname']
end

execute "hostname node['desired_fqdn']" do
  command "/bin/hostname #{node['desired_hostname']}"
  not_if "test `hostname` = #{node['desired_hostname']}"
  notifies :reload, 'ohai[reload_hostname]'
  notifies :reload, 'ohai[reload_fqdn]'
end

ohai 'reload_hostname' do
  action :nothing
  plugin 'hostname'
end

ohai 'reload_fqdn' do
  action :nothing
  plugin 'fqdn'
end