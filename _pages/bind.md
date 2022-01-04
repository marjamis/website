---
layout: default
title: Bind
---

## BIND

**NOTE:** The below examples are generally for both an Authoritative and Caching DNS Servers but with a little working can become Authoritative Only or Forwarding Only DNS Servers.

## Tasks

### Installing and configuring

* Install BIND and bind-utils, such as with:

### yum install bind bind-utils

* Edit the /etc/named.conf file and add an ACL to a trusted list of instances, this will need to be updated on changes to IP's or additions of secondaries. An example of this ACL is:

```bind
  acl "trusted" {
        172.31.7.46; #IP on this machine
        172.31.33.14; #Secondary DNS Servers IP
        localhost;
  };
```

* Add into/create a directive for allow-query and list the above ACL or potentially add the any; directive if anyone should be able to access this DNS server though generally this should be locked to a specific subnet for internal communication only and not made public. An example of this configuration with both the ACL and allow any query:

```bind
  allow-query     { trusted; any; };
```

* Configure the listen-on directive to set what ports the DNS Service listens on. An example of this:

```bind
  listen-on port 53 { 127.0.0.1; 172.31.7.46; };
  //listen-on-v6 port 53 { ::1; }; # This is commented out as this DNS server isn't configured to listen on IPV6 addresses.
```

* At the bottom of this global configuration add an include for a secondary configuration file. Example:

```bind
  include "/etc/named/named.conf.local";
```

* In this additional configuration file that you have included add in the required zones/configurations. This is discussed later in this document.

### Configure a new Zone

* In a existing/new configuration file a Primary's configuration, create the listing of the forward and reverse zones you're creating. A sample of this configuration file is:

```bind
  zone "test.marjamis.lab.myinstance.com" {
        type master; # Specifies this DNS Server is the Primary Authoritative for the zone
        file "/etc/named/zones/db.test.marjamis.lab.myinstance.com"; # Location of the file zone db
  };
  
  zone "31.172.in-addr.arpa" { # Network Octets in reverse order
        type master; # Specifies this DNS Server is the Primary Authoritative for the zone
        file "/etc/named/zones/db.172.31"; # Location of the file zone db
  };
```

* Change the permissions on the /etc/named directory so that BIND can access the zone files. An example is:

```bash
chmod 755 /etc/named
```

* Now we need to create the db's for the above listed forward/reverse zones. Each will need a basic configuration similar to the below which configures the basic requirements of a zone though there are plenty of other configuration. The base of each of these files is:

```bind
  $TTL 86400 #
  @       IN      SOA     <ns> <email> ( # @ will substitute the set or generated $ORIGIN, ns is the primary name server for this zone and email is for the email address of who's responsible for this zone. **NOTE:** the @ in an email address is substituted for a dot in the configuration file.
              3         ; Serial # Identifier to BIND on whether to use the new settings. Must be higher than the previous version on reload to take effect.
             604800     ; Refresh # This is the refresh interval for the zone. This is the amount of time that the slave will wait before polling the master for zone file changes.
              86400     ; Retry # This is the retry interval for this zone. If the slave cannot connect to the master when the refresh period is up, it will wait this amount of time and retry to poll the master.
            2419200     ; Expire # This is the expiry period. If a slave name server has not been able to contact the master for this amount of time, it no longer returns responses as an authoritative source for this zone.
             604800 )   ; Negative Cache TTL # This is the amount of time that the name server will cache a name error if it cannot find the requested name in this file.
```

* Once the basics are in place you can now add the required DNS Resource Records(RR's) as needed. Look at the documentation for specifics but the general format is:

```bind
  <URL> IN A <ipv4 address> # A
  <URL> IN AAAA <ipv6 address> # AAAA
  <URL> IN CNAME www.google.com. # CNAME
  IN NS <URL> # NS, beginning URL for an NS isn't required as it's a zone wide parameter
  IN MX <URL> # Mail Record,  beginning URL for an NS isn't required as it's a zone wide parameter
  <URL> IN TXT "Whatever data you want" # TXT
* IN A <ipv4 address> # Resolves anything under the domain that isn't defined explicitly. Like a default.
  
  <host octets(reversed) IN PTR <URL> # PTR in reverse zone
```

* Once the configurations are made, you can check the syntax for the named.conf* file/s that we  made with:

```bind
named-checkconf
```

* Then check each zone DB file is correct with:

```bind
named-checkzone <zone> <location of db file>
```

* Assuming all these checks pass you can then reload/start the DNS server and check the RR's in place work.

### Configure a Secondary DNS Server

* Install BIND on a second machine
* Edit the /etc/named.conf on the Primary and configure the option allow-transfer to have the IP of the secondary DNS server. Such as:

```bind
allow-transfer { 172.31.33.14; };
```

* Edit the /etc/named.conf file on the Secondary and configure the same base ACL's, listen-on and options configurations as mentioned above for a primary with any required differences. Also add the additional include for the the additional configuration file.
* Open this included configuration file and add in the zones that we've created on the primary but instead of being masters they will be listed as slaves. An example of this configuration is:

```bind
zone "test.marjamis.lab.myinstance.com" {
    type slave;
    file "slaves/test.marjamis.lab.myinstance.com";
    masters { <IP_of_Primary>; };
};

zone "31.172.in-addr.arpa" {
    type slave;
    file "slaves/db.172.31";
    masters { <IP_of_Primary>; };
};
```

* Once again check the configuration files with:

```bash
# named-checkconf
```

* Now reload/restart BIND.

### Updating DNS Records

* Log into DNS server
* Backup the current zone files as specified in the configuration file/s which can be found from the file:

```bash
  /etc/named.conf
```

* Edit the required zone file/s with the changes. To get the right zone file check the configuration file/s.
* Once the required alterations are made, change the date/increment in the header Serial number for a unique serial number for named to determine there is a change.
* Do the same for the reverse zones file/s.
* Reload named.

### Updating forwarders

* Backup the configuration files for named, the default being:

```bash
  /etc/named.conf
```

* Add a new section, such as:

```bind
  zone "new" {
    type forward;
    forwarders { <ip>; <ip>; };
  };
```

* Reload named.
* Test the new additions/deletions with dig.

### Backout Plan

* Restore the files you have backed up, update the serial number again so the change takes effect.
* Reload named.

### Reload named

Examples are:

```shell
  AIX: # refresh -s named
  Linux: # systemctl reload named
```

## General Information

### Configurations / Definitions

| Chroot and Setuid | BIND can run in a chrooted and limited user id for added security precautions. |
| --- | --- |
| options statement: notify | A mechanism that allows master servers to notify their slave servers of changes to a zone’s data. Configuration options on the servers that can be notified/updated are available. |
| Load Balancing | A primitive form of load balancing can be achieved in the DNS by using multiple records (such as multiple A records) for one name. |
| DNSSec |  |
| Glue records | In this case, the name server providing the delegation must also provide one or more IP addresses for the authoritative name server mentioned in the delegation. This information is called glue. The delegating name server provides this glue in the form of records in the additional section of the DNS response, and provides the delegation in the authority section of the response. A glue record is a combination of the name server and IP address. |
| options statement: recursion | If yes, will attempt to resolve every query. |
| options statement: querylog | Specify whether query logging should be started when named starts. |
| view statement | The view statement is a powerful feature of BIND 9 that lets a name server answer a DNS query differently depending on who is asking. It is particularly useful for implementing split DNS setups without having to run multiple servers. |
| IN | As from the [RFC1035](http://www.ietf.org/rfc/rfc1035.txt), it means the Internet |
| $ORIGIN | Explicitly specified in the zone file or synthesized from the zone name from the zone configuration, it defines the base name from which 'unqualified' names (those without a terminating dot) substitutions are made when processing the zone file. $ORIGIN is used in two contexts during zone file processing: 1.The symbol @ forces substitution of the current (or synthesized) value of $ORIGIN. The @ symbol is replaced with the current value of $ORIGIN. 2. The current value of $ORIGIN is added to any 'unqualified' name (any name which does not end in a 'dot').|
| $GENERATE | Used to create a series of resource records that only differ from each other by an iterator. |
| @ | A placeholder that substitutes the contents of the $ORIGIN |
| Root DNS Servers | Top of the DNS system are the "root servers" which are controlled by ICANN. Root servers, currently 13, use a broadcast system where all the mirrors of the 13 root servers have the same IP on the internet allowing requests to route to the closest copy of that root server. They handle details about TLD's. |
| TLD | Top Level Domain, e.g. .com and .au. Directed to from the Root DNS Servers to find the IP of a domain to be returned or to continue the search for the IP of a sub-domain. |
| Recursive | Performs recursive look-ups on a query to supply a response. |
| Iterative |  |
| Hint | The initial set of root name servers is specified using a "hint zone". When the server starts up, it uses the root hints to find a root name server and get the most recent list of root name servers. If no hint zone is specified for class IN, the server uses a compiled-in default set of root servers hints. Classes other than IN have no built-in defaults hints. |
| Dynamic DNS Updates | Dynamic Update is a method for adding, replacing or deleting records in a master server by sending it a special form of DNS messages. Any update via this process will be stored in the zone's journal file. |
| Zone transfer | Secondary servers load the zone contents from another server using a replication process known as a zone transfer. |
| Stealth Servers | A stealth server is a server that is authoritative for a zone but is not listed in that zone’s NS records. Stealth servers can be used for keeping a local copy of a zone to speed up access to the zone’s records or to make sure that the zone is available even if all the ”official” servers for the zone are inaccessible. |
| Built-in Empty Zones | Named has some built-in empty zones (SOA and NS records only). These are for zones that should normally be answered locally and which queries should not be sent to the Internet's root servers. These general follow the normal non-routable IP ranges.|
| Stub Zone | A stub zone is similar to a slave zone, except that it replicates only the NS records of a master zone instead of the entire zone. Stub zones are not a standard part of the DNS; they are a feature specific to the BIND implementation. |

#### Types of DNS

**NOTE:** For greater details on any configurations use official documentation.

| Type of DNS | Meaning | Requirements |
| --- | --- | --- |
| Authoritative | Returns the details of Resource Records for Forward/Reverse zones it controls. If configured for Authoritative Only, any request that it can't provide and answer to from it's zone will be responded without any recursive attempt. Route53 is an example of an Authoritative Only DNS server. Authoritative is zone specific, therefore one machine can be a primary for a particular zone and secondary for another zone. | Has zone files and is configured to use them. |
| Caching/Resolver/Recursive | Handles recursive queries and generally can handle the grunt work of tracking down DNS data from other servers. Returns the answer to the client and stores the record in cache based on TTL. | In /etc/named.conf, have recursion set to yes or allow-recursion specifying an ACL. |
| Forwarding | A forwarding DNS server offers the same advantage of maintaining a cache to improve DNS resolution times for clients. However, it actually does none of the recursive querying itself. Instead, it forwards all requests to an outside resolving server and then caches the results to use for later queries. This may be an advantage in environments where external bandwidth transfer is costly, where your caching servers might need to be changed often, or when you wish to forward local queries to one server and external queries to another server. | In /etc/named.conf, use the forwarders configuration to specify which other public/private DNS Servers any incoming request should be sent to and specify forward only. A typical scenario would involve a number of internal DNS servers and an Internet firewall. Servers unable to pass packets through the firewall would forward to the server that can do it, and that server would query the Internet DNS servers on the internal server’s behalf. |
| Stub Resolver | The resolver libraries provided by most operating systems are stub resolvers, meaning that they are not capable of performing the full DNS resolution process by themselves by talking directly to the authoritative servers. Instead, they rely on a local name server to perform the resolution on their behalf. |  |
| Split DNS | Setting up different views, or visibility, of the DNS space to internal and external resolvers is usually referred to as a Split DNS setup. There are several reasons an organization would want to set up its DNS this way. | Configurations of these views in ACL's or some other configuration.|

### rndc operations

rndc is a BIND server control utility that allows to configure the run-time configurations of BIND. Many, if not all, of these will temporarily change how BIND operates but on a restart of the named process the defaults will be restored so permanent modifications requires updating the named configuration files.

| Command | Function |
| --- | --- |
| rndc querylog | Will result in all queries being logged to /var/log/messages. |
| rndc dumpdb -cache | Will dump the cached addresses in the location specified in the named.conf file for the setting dump-file |
| rndc reload | Will reload the named server it's connecting to, by default localhost. |

### Other commands

| Command | Function |
| --- | --- |
| named-compilezone | Similar to named-checkzone, but it always dumps the zone content to a specified file (typically in a different format). |
| nsupdate | A utility to submit Dynamic DNS Updates to a name server. |

### Files and their purpose

| File | Usage |
| --- | --- |
| /etc/rndc.key | A shared secret key used by the rndc to communicate with a remote name server. |

## Useful links

* [Bind Documentation \- Version BIND 9.8](http://www.bind9.net/arm98.pdf)
* [Zytrax DNS](http://www.zytrax.com/books/dns/)
