---
layout: default
title: Environment Ideals
---

## {{ page.title }}

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

* [Accelerate] by Nicole Forsgren, Jez Humble, Gene Kim - A great breakdown of the importance of DevOps and what specific actions/tooling/etc correlate with better, safer, and faster deployments. I can't stress how much I love this and that it breaks down how the research was conducted
* ROI on my own thing, calculated based of usage/time/etc for a digestible value
* Most common areas of DevOps:
  * Infrastructure Automation - Create your systems, OS configs, and app deployments as code.
  * Continuous Delivery - built, test, deploy your apps fast and in an automated manner.
  * Site Reliability Engineering - operate your system, monitor and orchestration but also designing for operability in the first place.
* Outcomes over output basically ensure the metrics are driving the desired results rather than a metric that just says something happened. For example, feature releases are fine but what were there outcomes? Such a documented reduction in TOIL rather than we released 5 features. As usual, Martin Fowler is a good source of information surround this with [Outcome Over Output]( https://martinfowler.com/bliki/OutcomeOverOutput.html)

#### CI/CD

##### How to rollout changes

* recreate: terminate the old version and release the new one
* ramped: release a new version on a rolling update fashion, one after the other
* blue/green: release a new version alongside the old version then switch traffic
* canary: release a new version to a subset of users, then proceed to a full rollout
* a/b testing: release a new version to a subset of users in a precise way (HTTP headers, cookie, weight, etc.). This doesn’t come out of the box with Kubernetes, it imply extra work to setup a smarter loadbalancing system (Istio, Linkerd, Traeffik, custom nginx/haproxy, etc).
* shadow: release a new version alongside the old version. Incoming traffic is mirrored to the new version and doesn't impact the response.

### SRE

* [Google's SRE Books](https://sre.google/books/) - As expected these are good sources of information and practices. Definitely worth a read on a regular basis
  * [The Site Reliability Workbook](https://sre.google/workbook/table-of-contents/)
  * [Site Reliability Engineering](https://sre.google/sre-book/table-of-contents/)
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
* [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
* [Friday Deploy Freezes Are Exactly Like Murdering Puppies](https://charity.wtf/2019/05/01/friday-deploy-freezes-are-exactly-like-murdering-puppies/) - A bit of a walkthrough of why and how to stop the concept, "It's Friday, Don't push to prod"
* Build security principles in early to avoid costly rework. Shifting left on security is important in the long run. How exactly? That's a good question. Some good base fundamentals to know are:
  * Threat Assessment
  * https://owasp.org/Top10/

### Code Reviews

* [How to Make Good Code Reviews Better](https://stackoverflow.blog/2019/09/30/how-to-make-good-code-reviews-better/)
* [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) - A specification for adding human and machine readable meaning to commit messages
