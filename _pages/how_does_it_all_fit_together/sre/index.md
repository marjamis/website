---
layout: fit_together
title: SRE (Site Reliability Engineering)
category: sre
location: how_does_it_all_fit_together/sre
resources:
- title: Google's SRE Books
  link: https://sre.google/books/
  description: As expected these are good sources of information and practices. Definitely worth a read on a regular basis
- title: The Site Reliability Workbook
  link: https://sre.google/workbook/table-of-contents/
  description: 
- title: Site Reliability Engineering
  link: https://sre.google/sre-book/table-of-contents/
  description: 
---

## Why do we need SRE's?

Reliability, we will define this a bit later, of services is paramount to having a functioning service that your customers will want to use. To that end having engineers who's expertise is helping DevOps teams (or combinations of) to ensure this reliability is a great way to ensure that expertise is availalble to all teams who need it.

## What is reliability?

This will differ based on the service, sometimes this is uptime of the service, sometimes is being able to count of lack of errors, etc. Commonly it's a mixture of all of these.

## What do SRE's do?

* Reduce toil (which also has to be captured) via automation

## Techniques to improve reliability

* [Chaos Engineering](http://principlesofchaos.org/) - Chaos in production system, such as with Netflix's Chaos Monkey/Kong/etc, to ensure even during failures the system is resilient
* When scaling both vertically and horizontally consider all levels of the application flow, such as if the application scales up will the services it had dependencies also be able to scale up
