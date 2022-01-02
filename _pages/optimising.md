---
layout: default
title: Thing to remember when looking for optimisations
---

**Adapted from:** [AWS re:Invent 2014 | (WEB401) Optimizing Your Web Server on AWS](https://www.youtube.com/watch?v=ZfY0kwYiBRY)

## Important factors to think about

* Define what you optimising - tps, latency, cost, etc
* Optimising is part of the application, when deploying have the optimisations applied with it
* Always test and validate - build into testing to ensure valid to current version of the application
* Production data is king, use this known data for testing, including replaying of production data/loads against your testing environment
* Take advantage of your logs
* Metric management - break down the logs and information rather than relying on overall averages i.e. track times in sections of processing (internet->elb->back-end) or types of application requests(gets vs posts)
