---
layout: default
title: My Code Review Checklist
---

# My Code Review Checklist

## Resources

* [Stackoverflow: Why SOLID principles are still the foundation for modern software architecture](https://stackoverflow.blog/2021/11/01/why-solid-principles-are-still-the-foundation-for-modern-software-architecture/)

## Checklist

These are designed for me to keep an eye on and ensure I remember a lot of these before generating a **CR (Code Review)** / **PR (Pull Request)** while ensuring I perform any required refactorings. Each item won't always be adhered to 100% of the time, as it depends on the specifics but is to be used as a guide.

| Based on... | Item | Meaning... |
| --- |
| SOLID | Each module should do one thing and do it well. | |
| SOLID | Software entities should be open for extension, but closed for modification. | |
| SOLID | If S is a subtype of T, then objects of type T may be replaced with objects of type S without altering any of the desirable properties of the program. | |
| SOLID | Many client-specific interfaces are better than one general-purpose interface. | |
| SOLID | Depend upon abstractions, not concretions. | Use interfaces rather than relying on concrete classes. For example, rather than using S3 clients directly use an interface so S3 can be switched at any point without changing my code. |
