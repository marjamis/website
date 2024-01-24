---
title: SLA, SLO, and SLI's
resources:
  - title: |
      Are your SLOs realistic? How to analyze your risks like an SRE
    link: https://cloud.google.com/blog/products/devops-sre/how-sres-analyze-risks-to-evaluate-slos
  - title: |
      Setting SLOs: a step-by-step guide
    link: https://cloud.google.com/blog/products/management-tools/practical-guide-to-setting-slos
  - title: |
      Availability Table: Keep in mind when creating SLI's, SLO's, and SLA's
    link: https://sre.google/sre-book/availability-table/
---

To be able to say your service is reliable the first thing that you need to be able to do is quantify what reliable is for your service and a way to measure.

To that end we have:

- **SLI** - quantitative measurements that make up what makes your customers happy when using your service. i.e. Good Events / All Valid Events. Examples being, tps, latency, and error rates
- **SLO** - internal targets for your SLI's to track your services reliability. These should be lower than your SLA to ensure action before breaking your agreements. This is also a weather vein for are you spending your engineers time on the right things, too much reliability means your likely not spending time on features fast enough or you don't have a reliable enough service and you should concentrating on improving this
- **SLA** - business agreements with specific targets, based off of your SLO, with penalties for not hitting these targets

## How to set targets?

- Measure the current environments metrics and set something comfortable, while being aggressive to ensure improvements. It's also important to not have too high a "reliability value" as there are tradeoffs
- Make sure to re-evaluate these on a regular basis. Always iterate to:
  - make better systems (wrong values can make worse systems)
  - ensure customers expectations are met, i.e. making sure their is sufficient reliability compared to customers expectations of your service while also not having too much reliability, as this likely means you're not spending sufficient time on new features/functionality
- Ensure all stakeholders agree. If agreement can't be met then setting SLI's, SLO's, and SLA's will likely not provide the expected returns on ensure customer and company-wide satisfaction. This is where the notion that it's about a philosophical change to how a company operates and not simply some metrics on a dashboard
- Monitor, monitor, monitor

### Other related areas that can, and probably should be, explored for ensuring you're reliability

**Note:** Estimations are for assumptions when data is not available.

- **CUJ** - Critical User Journey's
- **TTD** - Time to detection
- **TTR** - Time to repair
- **ETTD** - Estimated time to detection
- **TBF** - Time between failures
- **ETTR** - Estimated time to repair
- **RTO** - Recovery Time Objective
- **RPO** - Recovery Point Objectives
