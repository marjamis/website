---
layout: default
title: Apache
---

## Configuration

### Configure Apache to set headers with responses

The below is an example of setting a header with text and the other setting the normally used Cache-Control header:

```apache
  Header [condition] set test "This is a string."
  Header [condition] set Cache-Control max-age=30
```

[condition] can be:

* always - will be used no matter the HTTP response.
* onsuccess - will be used if the Request is successful, such as HTTP 200 responses.

There can be several difference actions in the place of set:

* set - Replaces any previous header with same name.
* append - Appends to any existing header with the same name, comma separated.
* merge - Same as append unless the value already exists in the header, eliminates duplication.
* add - Added to the existing set of headers, even in the can of that header already existing.
* unset - Removes any header of that name if it exists, if multple headers of the same name all will be removed.
* echo - Request headers with this name are echoed back in the response.
* edit - If the response header exists it will be transformed based on a regex search and replace.

The available variables that can be used to return data are:

* %% - The percent sign
* %t - UTC time of when the request was received
* %D - Measure the duration of the request, from received time to response time
* %{FOOBAR}e - The contents of the environment variable FOOBAR.
* %{FOOBAR}s - The contents of the SSL environment variable FOOBAR, if mod_ssl is enabled.

### Virtual Hosts

#### IP Based

You are able to specify multiple web pages which connect to the one host and separate which page to load based on the private/public IP address that is used. Example, this uses the private IP's which are associated with a physical or virtual interface:

```apache
Listen 80

<VirtualHost 172.20.30.40>
DocumentRoot /www/example1
ServerName www.example.com
</VirtualHost>

<VirtualHost 172.20.30.50>
DocumentRoot /www/example2
ServerName www.example.org
</VirtualHost> 
```

#### Server Name Based

You are able to specify multiple web pages which connect to the one host and separate which page to load based on the server name. Example:

```apache
Listen 80
NameVirtualHost *:80

<VirtualHost *:80>
DocumentRoot /www/example1
ServerName www.example.com
</VirtualHost>

<VirtualHost *:80>
DocumentRoot /www/example2
ServerName www.example.org
</VirtualHost>
```

#### Name based for sub-domains

**NOTE:** This could be used specifying a mixture of options but for simplicity this is same IP and same port.

This requires the Host header being sent to the webserver to determine which content to return, otherwise it will return the default listing. This configuration would allow the URL's:

* www.domain.tld
* www.sub1.domain.tld
* www.sub2.domain.tld

to be run on this webserver and return the content for the correct domain. Will require entries for each of the URL above in DNS to be associated with the IP of this webserver.  

```apache
NameVirtualHost *:80

<VirtualHost *:80>
# primary vhost
DocumentRoot /www/subdomain
RewriteEngine On
RewriteRule ^/.* /www/subdomain/index.html
</VirtualHost>

<VirtualHost *:80>
DocumentRoot /www/subdomain/sub1
ServerName www.sub1.domain.tld
ServerPath /sub1/
RewriteEngine On
RewriteRule ^(/sub1/.*) /www/subdomain$1
</VirtualHost>

<VirtualHost *:80>
DocumentRoot /www/subdomain/sub2
ServerName www.sub2.domain.tld
ServerPath /sub2/
RewriteEngine On
RewriteRule ^(/sub2/.*) /www/subdomain$1
</VirtualHost>
```
