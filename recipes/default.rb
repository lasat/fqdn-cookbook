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

# Calculate hostname and FQDN based on the node.name
# If set via an attribute, calculate based on that.
# Otherwise, derive from the chef nodename.

require 'pry'

unless node['custom_fqdn'].nil?
  if node['custom_fqdn'].split('.').count >= 3
    dnsdomainname = node['custom_fqdn'].split('.').pop(2).join('.')
    hostname = node['custom_fqdn'].split('.')[0..(node['custom_fqdn'].split('.').count - 3)].join('.')
    fqdn = [hostname, dnsdomainname].join('.')
    hostname = fqdn if node['fqdn_as_hostname']
  end

  if node['custom_fqdn'].split('.').count == 2
    hostname = node['custom_fqdn']
    fqdn = hostname
  end

  if node['custom_fqdn'].split('.').count == 1
    hostname = "#{node['fqdn']}.example.com"
    fqdn = hostname
  end
else
  if node.name.split('.').count >= 3
    dnsdomainname = node.name.split('.').pop(2).join('.')
    hostname = node.name.split('.')[0..(node.name.split('.').count - 3)].join('.')
    node['desired_fqdn'] = [hostname, dnsdomainname].join('.')
    node['desired_hostname'] = fqdn if node['fqdn_as_hostname']
  end

  if node.name.split('.').count == 2
    node['desired_hostname'] = node.name
    node['desired_fqdn'] = hostname
  end

  if node.name.split('.').count == 1
    node['desired_hostname'] = "#{node.name}.example.com"
    node['desired_fqdn'] = hostname
  end
end

binding.pry

Chef::Log.info("desired_hostname: #{node['desired_hostname']}")
Chef::Log.info("desired_fqdn: #{node['desired_fqdn']}")

case node['platform_family']

when 'rhel'
  include_recipe 'fqdn::_rhel'
when 'debian'
  include_recipe 'fqdn::_debian'
end
