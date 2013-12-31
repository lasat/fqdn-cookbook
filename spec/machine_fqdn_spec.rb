require 'spec_helper'

describe 'MachineFqdn' do
  
  context 'there are two dots and hostname is set to fqdn' do
    before do
      node = Chef::Node.new
      node.default['desired_hostname'] = 'working.computers.biz'
      node.default['desired_fqdn'] = 'working.computers.biz'
    end
  end

  context 'there are two dots and hostname is first part of the fqdn' do
    before do
      node = Chef::Node.new
      node.default['desired_hostname'] = 'working'
      node.default['desired_fqdn'] = 'working.computers.biz'
    end
  end
  
end
