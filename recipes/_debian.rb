#
# Cookbook Name:: fqdn
# Recipe:: debian.rb
#
# Author:: Sean OMeara
# Copyright 2013, Chef Software, Inc.
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

machine_fqdn = MachineFqdn.new node

hostsfile_entry '127.0.0.1' do
  hostname machine_fqdn.fqdn
  aliases [
    machine_fqdn.hostname,
    'localhost',
    'localhost.localdomain'
  ]
end

hostsfile_entry '127.0.1.1' do
  hostname machine_fqdn.fqdn
  aliases [
    machine_fqdn.hostname,
    'localhost',
    'localhost.localdomain'
  ]
end

hostsfile_entry '::1' do
  hostname machine_fqdn.fqdn
  aliases [
    machine_fqdn.hostname,
    'localhost',
    'localhost.localdomain'
  ]
end

hostsfile_entry 'ff02::1' do
  hostname machine_fqdn.fqdn
  aliases [
    machine_fqdn.hostname,
    'localhost',
    'localhost.localdomain'
  ]
end

file '/etc/hostname' do
  content "#{machine_fqdn.hostname}\n"
  not_if "test `hostname` = #{machine_fqdn.hostname}"
end

execute "hostname #{machine_fqdn.fqdn}" do
  command "/bin/hostname #{machine_fqdn.hostname}"
  not_if "test `hostname` = #{machine_fqdn.hostname}"
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
