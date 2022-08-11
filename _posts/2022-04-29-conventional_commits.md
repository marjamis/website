---
title: Using Conventional Commits to write better commit messages
date: 2022-04-29 19:52:40 +1100
categories:
  - code-management
---

Commit messages are important as they should outline what was changed in that commit and potentially more importantly why it was done. A good way to ensure this information is available in your commits is to define a convention for the formatting of these messages and one such convention is [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

Conventional commits defines itself as:
> A specification for adding human and machine readable meaning to commit messages

This means the specification defines a format to commit messages in order for it to answer the questions of what, why and also importantly did the author think this commit would break anything which is useful not only to a person reading the message but as it has a consistent format makes tools that read these messages more easily able to parse the information as well.

Here's a look at the specifications format:

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Another benefit of using this specification is that while it comes with a list of pre-defined types there isn't stopping the use of subsets or additional types based on your teams requirements. This makes it customisable to how you want to use it for your specific use-case.

As this is a pre-defined format for commit messages this has lead to the creation IDE plugins that ensure you remember each field that you can/should add. For example, Visual Studio Code has the [Conventional Commits](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits) extension by viaxy which makes it super easy to generate these Conventional Commit formatted commit messages. This is the extension I currently use and it's definitely helped ensure I write better commit messages.
