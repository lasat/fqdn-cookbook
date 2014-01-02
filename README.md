# fqdn cookbook

# STATUS
This cookbook is not yet ready for use in production. It should only
be used in testing situations such as cookbook development.
Specifically, the line editing library it depends on contains bugs
and will edit files over multiple runs in certain circumstances.

# Description
There is an unfortunate amount of confusion and misunderstanding
around the term FQDN. The acronym stands for "Fully Qualified Domain
Name". This leads to some confusion about the relationship between it
and a hostname. It would be better called "Fully Qualified DNS Host Name".

On linux, it is found by issuing the command `hostname -f`. On
Solaris, there is no such thing, but you can set a dnsdomain name.

Linux will only return data when the proper bits are aligned in
/etc/hosts. The order of these bits need to be in is determined by the
version of glibc on the system. Solaris works a different way. Don't
even get me started on Windows.

How this gets set initially comes from many different directions. Some
Enterprises will keep a standard naming scheme and inject hostnames
and fqdns into hosts during provisioning. Some Cloud providers will
supply you with forward and reverse DNS, visible from the running
system. Some wont. Sometimes you get a machine who's hostname is set to
"computer" with no notion of being on a DNS domain at all.

Lots of server software breaks when a machine's FQDN is not properly
set. Chef recipes that refer to the FQDN attribute will error Ohai is
unable to determine what the FQDN should be.

Frankly, the whole thing is a mess.

This cookbook aims to easily set an FQDN on machines where it is not
properly set out of the box.

# Attributes
```
default['machine_fqdn'] = nil
default['machine_fqdn_as_hostname'] = true
```

# Behavior
If included in the run_list, `fqdn::default` will attempt to repair
the machine's FQDN based on user supplied data. If the attribute
`node['machine_fqdn']` is set, it will use the string found there to
attempt to configuration the machine's hostname.

If node['machine_fqdn_as_hostname'] is set to true (it is by default),
it will configure the machine such that the hostname command returns
the full DNS path to the machine. That is, `hostname` and `hostname
-f` will return the same things on Linux machines.

# Requirements
```
line cookbook
hostsfile cookbook
```

# Usage
`include_recipe 'fqdn'`

# Recipes
debian.rb
rhel.rb

# Author
Author:: Sean OMeara (<someara@opscode.com>)
