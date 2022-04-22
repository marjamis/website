{% assign any_pages = false %}
{% assign sorted_pages = site.pages | where_exp: "item", "item.title != 'Index'" | sort: 'title' %}
<ul>
  {% for p in sorted_pages %}
  {% if p.path contains page.location %}<li><a href="{{ p.url }}">{{ p.title }}</a></li>{% assign any_pages=true %}{% endif %}
  {% endfor %}
</ul>


{% if any_pages == false %}
No content currently...
{% endif %}
