---
layout: default
title: How does it all fits together?
---

This is my guide to how everything in IT (or at least the parts I'm involved in) fit together. There are a lot, and I mean A LOT, of technologies, practices, thoughts, etc. that come together to make up what is an IT system. There are:

* the applications which run the software
* the programming languages used to create the applications
* the deployment processes to get the software on to the servers
* the servers that exist to run your applications
* the networking that allows these systems to communicate
* the DevOps practices which are taking hold to make this all easier
* the SRE practices which are trying to make everything reliable in an unreliable world

plus many, many more. My goal with this section is to try to put some order to these and allow for some cross polination of these ideas across the bounds. Unfortunately, at least in my mind, this is quite a complicated task with out strict borders between each but through this guide Ill try to make some order and see where I get to. This will likely mean these pages change on a constant basis to ensure the most accurate information and the best flow of information is available to each.

I hope this is useful for others but at a minimum this will help me to document my view of the state of IT and how I can try to make it as good as possible.

To that end while I work out the best structure for each of these I will have the following genereal areas the posts will be broken into. These being:

* DevOps practices and technologies
* SRE practices
* Observability
* Programming Concepts
* Containers - both linux side and orchestartors
* Programming Language Specifics - primarily go and python
* Technology Leadership and Change

My goal is also to have a consistent stream of content to ensure my learning isn't stalled.

### My core areas of focus

| Programming Languages | Platforms | Cloud | Additional areas |
| --- | --- | --- | --- |
| Go | Kubernetes | AWS | DevOps, CI/CD, all the buzz words |
| Python | ECS  | GCP | Security |
| Javascript | EKS | | Networking |
| | Containers | | Observability |


### To migrate

{% include list_directory.md loc="migrate" %}
