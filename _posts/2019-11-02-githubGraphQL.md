---
title: Using Github's GraphQL
date: 2019-11-02 20:15:10 +11:00
categories:
  - example
---

Here is an example of how to make authenticated GitHub GraphQL queries to obtain information with a basic loop for paginated results. This is only a reference for simple requirements and anything more advanced probably **shouldn't** be a bash script.

More information about the format for queries and the API can be found at [GitHub's GraphQL API](https://developer.github.com/v4/) documentation.

Script:
{% gist 2b0088ead7fcb6ea2ccfb196818b2be6 githubGraphQL.sh %}

Query:
{% gist 2b0088ead7fcb6ea2ccfb196818b2be6 sample.query %}
