### {{ include.loc | capitalize  }}

<ul>
  {% for page in site.pages %}
    {% if page.path contains include.loc %}
  <li><a href="{{ page.url }}">{{ page.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>
