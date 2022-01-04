---
layout: default
title: Environment Ideals
---

## Environment Ideals

**Note:** Not all these are applicable for every size, use-case, etc. but should be thought of as some possible guidelines to follow or ignore depending on a variety of different factors.

### Security

* All API calls and IAM permissions should be auditable, comply to policies and backed up. All these should automatically occur.
* IAM credentials minimal as possible, in all respects. This includes the time they are valid.
* Reverse uptime to cycle instances after X days. Good for both security but also as a test of applications ability to handle failures.
* Consider considerations here: [12 best practices for user accounts](https://cloudplatform.googleblog.com/2018/01/12-best-practices-for-user-account.html)
* Risk Analysis - Determine the impact and likelihood of issues that may occur
* Using something like AWS SSO for centralised and stronger credential usage. Investigate more but should be a consideration.

#### Example Security Check applications

* [Docker Bench Security](https://github.com/docker/docker-bench-security)

### DevOps

#### General

* ROI on my own thing, calculated based of usage/time/etc for a digestible value
* Most common areas of DevOps:
  * Infrastructure Automation - Create your systems, OS configs, and app deployments as code.
  * Continuous Delivery - built, test, deploy your apps fast and in an automated manner.
  * Site Reliability Engineering - operate your system, monitor and orchestration but also designing for operability in the first place.

#### CI/CD

##### How to rollout changes

* recreate: terminate the old version and release the new one
* ramped: release a new version on a rolling update fashion, one after the other
* blue/green: release a new version alongside the old version then switch traffic
* canary: release a new version to a subset of users, then proceed to a full rollout
* a/b testing: release a new version to a subset of users in a precise way (HTTP headers, cookie, weight, etc.). This doesn’t come out of the box with Kubernetes, it imply extra work to setup a smarter loadbalancing system (Istio, Linkerd, Traeffik, custom nginx/haproxy, etc).
* shadow: release a new version alongside the old version. Incoming traffic is mirrored to the new version and doesn't impact the response.

### SRE

* Tracking of the reliability of a system, such as with:
  * SLI - Quantative measurements
  * SLO - binding targets that an SLI can be out of expected band - TODO function to work out the error budge based off of this from somwhere rather than typing it out. monitoring the SLI, with a graph/metric for compliance to the SLO and the remainder being the ErrorBudget. Dependency error budgets
  * SLA - business abstracts of contractual agreements to hit the above targets.
* Reducing TOIL (which also has to be captured) via automation
* When scaling both vertically and horizontally consider all levels of the application flow, such as if the application scales up will the services it connects to also be able to scale up
* DiRT Disaster Recovery Testing events and Game days - Perhaps should be done in testing accounts to ensure these things are tested for on occasion? More information:
  * [Weathering the Unexpected](http://queue.acm.org/detail.cfm?id=2371516)
* [Chaos Engineering](http://principlesofchaos.org/) - Chaos in production system, such as with Netflix's Chaos Monkey/Kong/etc, to ensure even during failures the system is resilient

### Creating Applications

* [12 Factor Applications](https://12factor.net)
* [Feature flags](https://martinfowler.com/articles/feature-toggles.html)
* [API Versioning](https://cloudplatform.googleblog.com/2018/03/API-design-which-version-of-versioning-is-right-for-you.html)
