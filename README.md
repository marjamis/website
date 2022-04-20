# Everything and anything...

---

{% include about.md %}

---

## How does it all fit together?

With everything become more complex, entangled but also separate, how do we link all these concepts together? I probably don't really know but [this is my attempt](./pages/how_does_it_all_fit_together/).

---

## Last 10 Posts (most recent first)

<ol>
  {% for post in site.posts offset: 0 limit: 10 %}
  <li>{{ post.date}} - <a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ol>

### All posts (by category)
{% assign sorted_categories = site.categories | sort %}
{% for category in sorted_categories %}
<a href="{{ site.url }}/category/{{ category | first | url_encode }}.html">{{ category | first | capitalize }}</a>
{%- endfor %}

### All pages

{% include list_directory.md loc="documentation" %}

{% include list_directory.md loc="misc" %}

---

**Are all links working?** [![Check Links](https://github.com/marjamis/marjamis.github.io/actions/workflows/links.yml/badge.svg)](https://github.com/marjamis/marjamis.github.io/actions/workflows/links.yml)

Why not also check with [W3C Link Checker](https://validator.w3.org/checklink?uri=marjamis.github.io&hide_type=all&depth=&check=Check).
