---
layout: default
title: Cloud Computing Ideals
---

## Cloud Computing Ideals

### Individual Tidbits

**Adapted from:** [AWS tips I wish I'd known before I started](https://wblinks.com/notes/aws-tips-i-wish-id-known-before-i-started)

* No state on servers - logs(syslog), session(database).
* Have the instance metaservice log additional information(like instance information) to the logs.
* Disable SSH via Security Groups as everything should be automated and no need to directly log into an instance.
* Shouldn't care if a server goes down due to AutoScaling Groups and Load Balancers.
* Avoid static/elastic IP's  - all instances behind LB's
* Automate everything, including patching
* Set up granular billing
* User roles -  no IAM accounts for applications
* Automated security auditing
* Enable API call logging
* Terminate SSL on Load balancers
* Scale horizontally in cloud
* Everything is set for multi AZ redundancy
* Decide on naming conventions and stick to it
* Always use MFA, even for IAM accounts

### AWS' General Principles for working in the cloud

**Adapted from:** AWS Principles

* Design for failure and nothing fails
* Loose coupling sets you free
* Implement Elasticity
* Build Security into every layer
* Don't fear constraints
* Think Parallel
* Leverage different storage options

### DDoS resilience in the Cloud

**Adapted from:** [AWS re:Invent 2014 \| (SEC307) Building a DDoS-Resilient Architecture with Amazon Web Services](https://www.youtube.com/watch?v=OT2y3DzMEmQ)

* Minimise your service area (basically if don't need to be public don't make them public), separation of duties and over internal connections where possible.
* If it needs to be public make them difficult to find(eg. over multiple IP addresses per service)
* Personal access(bastion host), public access(elb), instance to internet access(NAT)
* Cloudfront in front of services for obfuscation
* Web Application Firewall(WAF) filters application layer and can rate limit for your application
* Cloud Watch network and other metrics to determine DDoS. What is normal usage? This will need monitoring of the environment over time to determine trends and when things are abnormal.

## Useful Resources

### Documentation

* [Cloud Patterns](http://en.clouddesignpattern.org/index.php/Main_Page)

### Videos

* [AWS Summit Series 2016 \| Chicago - Another Day, Another Billion Packets](https://www.youtube.com/watch?v=yZtKcZdsCJk) - Useful as it makes me remap the broadstrokes of how VPC works. Also look for updates as there are new versions all the time
* [AWS May 2016 Webinar Series - Strategies to Optimize Costs Using AWS](https://www.youtube.com/watch?v=slJvH85fl00) - Useful for information about keeping costs of using AWS down.
