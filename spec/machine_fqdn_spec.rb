require 'spec_helper'
require_relative '../libraries/machine_fqdn.rb'
require 'pry'

describe 'MachineFqdn' do

  # no dots
  context 'there are no dots' do
    it 'should rause an argument error' do
      node = Chef::Node.new
      node.default['machine_fqdn'] = 'computer'
      expect { MachineFqdn.new node }.to raise_error(ArgumentError)           
    end
  end

  # one dot
  context 'there is one dot' do

    context 'machine_fqdn_as_hostname set to true' do
      before do
        node = Chef::Node.new
        node.default['machine_fqdn'] = 'computers.biz'
        node.default['machine_fqdn_as_hostname'] = true
        @machine_fqdn = MachineFqdn.new node
      end

      it 'should set everything to the correct values' do
        expect(@machine_fqdn.fqdn).to eq('computers.biz')
        expect(@machine_fqdn.hostname).to eq('computers.biz')
        expect(@machine_fqdn.dnsdomainname).to eq('biz')
      end
    end

    context 'machine_fqdn_as_hostname set to false' do
      before do
        node = Chef::Node.new
        node.default['machine_fqdn'] = 'computers.biz'
        node.default['machine_fqdn_as_hostname'] = false
        @machine_fqdn = MachineFqdn.new node
      end

      it 'should set everything to the correct values' do
        expect(@machine_fqdn.fqdn).to eq('computers.biz')
        expect(@machine_fqdn.hostname).to eq('computers')
        expect(@machine_fqdn.dnsdomainname).to eq('biz')
      end
    end
  end

  context 'there are two dots' do

    context 'machine_fqdn_as_hostname set to true' do
      before do
        node = Chef::Node.new
        node.default['machine_fqdn'] = 'working.computers.biz'
        node.default['machine_fqdn_as_hostname'] = true
        @machine_fqdn = MachineFqdn.new node
      end

      it 'should set everything to the correct values' do
        expect(@machine_fqdn.fqdn).to eq('working.computers.biz')
        expect(@machine_fqdn.hostname).to eq('working.computers.biz')
        expect(@machine_fqdn.dnsdomainname).to eq('computers.biz')
      end
    end

    context 'machine_fqdn_as_hostname set to false' do
      before do
        node = Chef::Node.new
        node.default['machine_fqdn'] = 'working.computers.biz'
        node.default['machine_fqdn_as_hostname'] = false
        @machine_fqdn = MachineFqdn.new node
      end

      it 'should set everything to the correct values' do
        expect(@machine_fqdn.fqdn).to eq('working.computers.biz')
        expect(@machine_fqdn.hostname).to eq('working')
        expect(@machine_fqdn.dnsdomainname).to eq('computers.biz')
      end
    end
  end

  # three dots
  context 'there are three dots' do

    context 'machine_fqdn_as_hostname set to true' do
      before do
        node = Chef::Node.new
        node.default['machine_fqdn'] = 'earth.working.computers.biz'
        node.default['machine_fqdn_as_hostname'] = true
        @machine_fqdn = MachineFqdn.new node
      end

      it 'should set everything to the correct values' do
        expect(@machine_fqdn.fqdn).to eq('earth.working.computers.biz')
        expect(@machine_fqdn.hostname).to eq('earth.working.computers.biz')
        expect(@machine_fqdn.dnsdomainname).to eq('working.computers.biz')
      end
    end

    context 'machine_fqdn_as_hostname set to false' do
      before do
        node = Chef::Node.new
        node.default['machine_fqdn'] = 'earth.working.computers.biz'
        node.default['machine_fqdn_as_hostname'] = false
        @machine_fqdn = MachineFqdn.new node
      end

      it 'should set everything to the correct values' do
        expect(@machine_fqdn.fqdn).to eq('earth.working.computers.biz')
        expect(@machine_fqdn.hostname).to eq('earth')
        expect(@machine_fqdn.dnsdomainname).to eq('working.computers.biz')
      end
    end
  end
end
