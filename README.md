## Everything and anything...

### Post Categories
<ul>
  {% for category in site.categories %}
  <li><a href="{{ site.url }}/category/{{ category | first | url_encode }}/index.html">{{ category | first }}</a></li>
  {% endfor %}
</ul>

{% include_relative pages/about.md %}
