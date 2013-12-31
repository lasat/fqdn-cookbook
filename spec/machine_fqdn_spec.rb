require 'spec_helper'

describe 'MachineFqdn' do

  context 'there are no dots' do
    before do
      node = Chef::Node.new
      node.default['machine_hostname'] = 'computer'
      node.default['machine_fqdn'] = 'computer'
    end
  end
  
  context 'there is one dot and hostname is set to fqdn' do
    before do
      node = Chef::Node.new
      node.default['machine_hostname'] = 'computers.biz'
      node.default['machine_fqdn'] = 'computers.biz'
    end
  end

  context 'there is one dot and hostname is the first part of the fqdn' do
    before do
      node = Chef::Node.new
      node.default['machine_hostname'] = 'computers'
      node.default['machine_fqdn'] = 'computers.biz'
    end
  end
  
  context 'there are two dots and hostname is set to fqdn' do
    before do
      node = Chef::Node.new
      node.default['machine_hostname'] = 'working.computers.biz'
      node.default['machine_fqdn'] = 'working.computers.biz'
    end
  end

  context 'there are two dots and hostname is the first part of the fqdn' do
    before do
      node = Chef::Node.new
      node.default['machine_hostname'] = 'working'
      node.default['machine_fqdn'] = 'working.computers.biz'
    end
  end

  context 'there are three dots and hostname is the first part of the fqdn' do
    before do
      node = Chef::Node.new
      node.default['machine_hostname'] = 'earth'
      node.default['machine_fqdn'] = 'earth.working.computers.biz'
    end
  end

  context 'there are four dots and hostname is the first part of the fqdn' do
    before do
      node = Chef::Node.new
      node.default['machine_hostname'] = 'middle'
      node.default['machine_fqdn'] = 'middle.earth.working.computers.biz'
    end
  end

  context 'there are four dots and hostname is the first two parts of the fqdn' do
    before do
      node = Chef::Node.new
      node.default['machine_hostname'] = 'middle.earth'
      node.default['machine_fqdn'] = 'middle.earth.working.computers.biz'
    end
  end
  
end
