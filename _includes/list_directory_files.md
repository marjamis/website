{% assign any_pages = false %}
<ul>
  {% for p in site.pages | sort: 'title' %}
  {% if p.path contains page.location and p.url != page.url %}
  <li><a href="{{ p.url }}">{{ p.title }}</a></li>
  {% assign any_pages=true %}
  {% endif %}
  {% endfor %}
</ul>

{% if any_pages == false %}
No content currently...
{% endif %}
