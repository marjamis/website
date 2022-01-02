---
title: How to get docker registry/repository information with curl
date: 2022-01-02 19:47:14 +11:00
categories:
  - docker
  - example
---

Ever had to get an image manifest for a docker image in a repository before? I know I have. Here's how you can achieve this with curl.

One way to do this is by using curl:

{% gist fe812a8657b714efb48b16204801d9cf docker_registry.sh %}

How about from ECR? Boy have I!

{% gist fe812a8657b714efb48b16204801d9cf ecr_registry.sh %}

and there you go, an easy way to use curl to authenticate and retrieve data from a docker image registry. No fuss, no muss.
