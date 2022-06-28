---
layout: resources
title: SLA, SLO, and SLI's
resources:
  - title: |
      Are your SLOs realistic? How to analyze your risks like an SRE
    link: https://cloud.google.com/blog/products/devops-sre/how-sres-analyze-risks-to-evaluate-slos
  - title: |
      Setting SLOs: a step-by-step guide
    link: https://cloud.google.com/blog/products/management-tools/practical-guide-to-setting-slos
---

To be able to say your service is reliable the first thing that you need to be able to do is quantify what reliable is for your service and a way to measure.

To that end we have:

* **SLI** - quantative measurements that make up what makes your customers happy when using your service. Examples being, tps, latency, and error rates
* **SLO** - internal targets for your SLI's to track your services reliability. These should be lower than your SLA to ensure action before breaking your agreements. This is also a weather vein for are you spending your engineers time on the right things, too much reliability means your likely not spending time on features fast enough or you don't have a reliable enough service and you should concentrating on improving this
* **SLA** - business agreements with specific targets, based off of your SLO, with penalties for not hitting these targets
