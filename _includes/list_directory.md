#### {{ include.loc | capitalize  }}

<ul>
  {% assign sorted_pages = site.pages | where_exp: "item", "item.title != 'Index'" | sort: 'title' %}
  {% for page in sorted_pages %}
    {% if page.path contains include.loc %}
  <li><a href="{{ page.url }}">{{ page.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>
