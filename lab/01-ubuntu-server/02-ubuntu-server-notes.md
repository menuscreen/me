# Ubuntu Server Notes

## Index

* [DNS](#dns)
* [Disable ipv6](#disable-ipv6)
* [Related Resources](#related-resources)

### DNS

> Domain Name Service (DNS) is an Internet service that maps IP addresses and fully qualified domain names (FQDN) to one another. In this way, DNS alleviates the need to remember IP addresses. Computers that run DNS are called name servers. Ubuntu ships with BIND (Berkley Internet Naming Daemon), the most common program used for maintaining a name server on Linux.

```bash
sudo apt install bind9
sudo apt install dnsutils
```

The DNS configuration files are stored in the /etc/bind directory. The primary configuration file is `/etc/bind/named.conf`, which in the layout provided by the package just includes these files.

* `/etc/bind/named.conf.options`: global DNS options
* `/etc/bind/named.conf.local`: for your zones
* `/etc/bind/named.conf.default-zones`: default zones such as localhost, its reverse, and the root hints

**Caching Nameserver**  
The default configuration acts as a caching server. Simply uncomment and edit `/etc/bind/named.conf.options` to set the IP addresses of your ISP’s DNS servers:

```bash
forwarders {
    1.2.3.4;
    5.6.7.8;
};
```

> Replace 1.2.3.4 and 5.6.7.8 with the IP Addresses of actual nameservers.

To enable the new configuration, restart the DNS server. From a terminal prompt:

```bash 
sudo systemctl restart bind9.service
```

### Disable ipv6

```bash 
sudo nano /etc/sysctl.conf
```

Add the following lines to disable the IPv6 services in this file:

```bash
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```

To apply the changes to the system, the “sysctl” command is utilized with the “p” option:

```bash
sudo sysctl -p
```

Users can verify the disabled IPv6 services after restarting the network services. For this, the “cat” command is utilized by specifying the configuration file path “disable_ipv6” to check the status of IPv6:

```bash
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```


### **Related resources**:

* [Ubuntu Docs DNS Service](https://ubuntu.com/server/docs/service-domain-name-service-dns)
