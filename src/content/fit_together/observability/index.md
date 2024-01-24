---
title: Observability
category: observability
---

Observability refers to the ability of a system’s output to sufficiently determine its state. Monitoring a system does not necessarily mean that you have all the information you need to determine the system’s state.

A good way that people have started to describe this as is:

> Monitoring is for known issues, such as error rates, where observability is to provide details about the unknown, such as a portion of the application not acting as expected that needs investigation.

## Summary of points from Rollbar

Rather than trying to make up my own thoughts on this, especially so early in my observability thinking, I've summaried my key take-aways from Rollbar's [Achieving Observability in Complex Modern Applications](https://www.slideshare.net/jatap/achieving-observabilityinmodernapplications). Overtime I will modify this to make it my own but this is a very good start on how to think about the observability practice.

### Requirements for achieving effective Observability

- Full-Stack Error Tracking
- Distributed Tracing
- APM (Application-Performance Management)
- Infrastructure Monitoring
- Log Aggregation and Analysis
- Incident Management

### Best Practices for achieving Observability

- **Good system architecture and development practices** - It’s critical that your system capture enough data to troubleshoot problems. Monitoring solutions only track what they can see. Logging solutions require you to add meaningful log statements to your code. Bugs should not surface to users without also tracking an error or warning on the backend.
- **Balance performance with visibility** - Swallowing exceptions may prevent a crash and improve application performance from the user’s perspective, but doing so reduces observability unless you log or track the error. Additionally, it’s great to have automatic retries and failover in your microservices architecture, but you should track when they happen in order to troubleshoot spikes in latency and dead letter queues. All of these examples require your team to design your architecture and your software in a way that enables it to be observed.
- **Shift-left processes** - The “shift-left” paradigm refers to the practice of performing tasks earlier in the delivery chain, rather than waiting until software is in production. By shifting processes such as error tracking and APM to the left (while still performing them in production, too), organizations gain earlier insights into software issues that may impact Rollbar on Achieving Observability in Complex Modern Applications 14 the user experience. Earlier insights lead to more effective observability by enabling teams to detect and respond to problems while still in integration or development environments. It’s more cost-effective to track debug-level information in these environments, making problems easier to address.
- **Continuous communication** - To the extent feasible, everyone on the DevOps team should understand the tools that are used to achieve observability, and should communicate constantly about observability insights provided by these tools. Not every team member needs to be an expert in every tool; that would not be realistic. However, everyone on the team should understand the basics of the observability toolset and its goals, and information should not be siloed or handed off manually from one part of the team to another. Otherwise, your system is effectively non-observable to people tasked with running it.
- **Prioritization policies** - A fully observable system will, by design, generate more data, so you need a way to prioritize what matters from a business or user-experience perspective. Not all performance problems or application errors are of equal seriousness, and in most cases they cannot all be addressed. In order to avoid overwhelming engineers with a never-ending stream of alerts, organizations should have policies in place that help to define which types of problems receive priority. You also need support from your monitoring tools to help you rank problems according to priority.
