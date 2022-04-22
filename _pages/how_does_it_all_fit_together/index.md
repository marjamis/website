---
layout: default
title: The IT industry, how does it all fit together?
---

# {{page.title}}

This is my attempt to find a way to convey the types of information I'm passionate about while also having them useful to the greater context of how a complex IT system operates. There are a lot of technologies, practices, thoughts, etc. that come together to make up what is an IT system and it can become quite messy and hopefully this will help provide a basis for being able to continue to learn and apply these to real world systems. Some examples of the areas that will have coverage are:

* applications that run our business functions - It's all well and good to have a great people but if there aren't any customers, you don't have much
* the programming languages used to create the applications
* the deployment processes to get the applications on to the servers and running
* the physical/virtual servers that exist to run the applications
* the networking that allows these systems to communicate
* the DevOps practices which are taking hold to make this all easier
* the SRE practices which are trying to make everything reliable in an unreliable world

plus many, many more.

Unfortunately, or fortunately as that's where some of the fun comes in, this is quite a complicated task without strict borders between each area though through this guide Ill try to make some order and see where I get to. This will likely mean these pages will change on a regular basis to ensure the most accurate information and the best flow of information is available for each.

My current breakdown is:

## Application

* [Programming Concepts](./programming-concepts/)
* [Programming](./programming/) - language specific information. Primarily for go and python with a bit of javascript in the mix
* [Code Management](./code-management/)

## Infrastructure

* [Containers](./containers/) - both the linux side (cgroups, namespaces, docker, etc) and orchestartors (primarily ECS and EKS/Kubernetes)
* [Cloud](./cloud) - Mainly AWS but GCP is bound to make a showing
* [Observability](./observability/)

## Philosophies and their implementations

* [DevOps](./devops/) - this include practices, like CI/CD, and specific technologies
* [SRE](./sre/) practices

## Hearts and minds

* [Technology Leadership and Change](./tech-leadership-change/)
* [Growth and Mental Health](./growth-mental-health/) - this is important but easily overlooked and is worthwhile to check-in with yourself every so often

**Note:** I haven't listed security anywhere as it should be throughout but this thinking may change. Let's see how we go...
