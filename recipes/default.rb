#
# Cookbook Name:: fqdn
# Recipe:: default
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

Chef::Log.info("desired_hostname: #{node['desired_hostname']}")
Chef::Log.info("desired_fqdn: #{node['desired_fqdn']}")

case node['platform_family']

when 'rhel'
  include_recipe 'fqdn::_rhel'
when 'fedora'
  include_recipe 'fqdn::_rhel'
when 'debian'
  include_recipe 'fqdn::_debian'
end
