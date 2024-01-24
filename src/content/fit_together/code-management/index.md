---
title: Code Management
category: code-management
resources:
  - title: |
      Git: How to unfuck
    link: https://www.youtube.com/watch?v=LP4F2rmi4r4
    description: Useful for a whole list of commands and procedures when you're in a broken state
  - title: Dangit, Git!?!
    link: https://dangitgit.com/
    description: Forgot how to unstick yourself with git? Have a look here
---

There are many aspects of code management that are important. To name a few there is the repository layout (such as should you use a monorepo or another strategy), the tools used to manage the code (this includes git but also GitHub/GitLab/etc), CI practices (to automate testing and reviewing of code), and Code Reviews (which attempt to make code the best it can be based on your teams knowledge before being committed to the main branch though perhaps this is less important with proper CI practices).

There is also the matter of **What do I put in my commit message?**. The best types of commit messages are written to let others know about what was done in this commit (at a high level) but also very importantly **Why was this commit needed?!**. If this question can't be answered by the commit message then it's likely not a good enough commit message for other to make sense of what you're doing.

Through the below posts and content I hope to expand upon some of these practices and tools to make everyones life easier in managing their code and how it relates to the people involved, both in writing and reviewing code.
