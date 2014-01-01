
class MachineFqdn
  attr_reader :fqdn, :hostname, :dnsdomainname

  def initialize(node)
    @fqdn = nil
    @hostname = nil
    @dnsdomainname = nil

    sanity_check node
    set_attributes node
  end

  private

  def sanity_check(node)
    dots = node['machine_fqdn'].split('.').count - 1
    fail ArgumentError, 'There must be least one dot in an FQDN' if dots < 1
  end
  
  def set_attributes(node)
    @fqdn = node['machine_fqdn']
    head, *tail = node['machine_fqdn'].split('.')

    if node['machine_fqdn_as_hostname']
      @hostname = node['machine_fqdn']
    else
      @hostname = head
    end
    @dnsdomainname = tail.join('.')
  end

end
