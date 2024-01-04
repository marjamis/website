# Everything and anything...

---
<p></p>
---

## Introduction

A place for me to try to explain things I've learnt or as a wrapper to other bits of code, such as in GitHub gists. While I strive for accuracy in all things I can't guarantee this so please take with a grain of salt and don't hesitate to create PR's for things you know are wrong.

To find out more about who I am, you can visit my:

* [LinkedIn](https://www.linkedin.com/in/jamismarch/) for a bit more about me and my work
* [GitHub Profile](https://github.com/marjamis/) to see my current projects and code bases

---
<p></p>
---

## The IT industry, how does it all fit together?

With the IT industry becoming more complex, entangled together but also being very diverse, how do we link all these thoughts and techniques together for a successful result? [This is my attempt](./pages/how_does_it_all_fit_together/) to work through this for myself and hopefully others will find it useful as well.

---
<p></p>
---

## Last 10 Posts (most recent first)

<ol>
  {% for post in site.posts offset: 0 limit: 10 %}
  <li>{{ post.date}} - <a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ol>

### Post Categories
{% assign sorted_categories = site.categories | sort %}
{% for category in sorted_categories %}
<a href="{{ site.url }}/category/{{ category | first | url_encode }}.html">{{ category | first }}</a>
{%- endfor %}

---
<p></p>
---

## Misc. Pages

- [Advent of Code Learnings](./pages/advent_of_code_lessons/)

---
<p></p>
---

**Are all links working?** [![Check Links](https://github.com/marjamis/marjamis.github.io/actions/workflows/links.yml/badge.svg)](https://github.com/marjamis/marjamis.github.io/actions/workflows/links.yml) or check with [W3C Link Checker](https://validator.w3.org/checklink?uri=marjamis.github.io&hide_type=all&depth=&check=Check).
