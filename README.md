## Everything and anything...

### Core competencies

| Languages | Platforms | Cloud |
| --- | --- | --- |
| Go | Kubernetes | AWS |
| Python | ECS  | GCP |
| Node | Containers | |

### Post Categories
<ul>
  {% for category in site.categories %}
  <li><a href="{{ site.url }}/category/{{ category | first | url_encode }}/index.html">{{ category | first }}</a></li>
  {% endfor %}
</ul>

### Pages
<ul>
  {% for page in site.pages %}
  <li><a href="{{ page.url }}">{{ page.title }}</a></li>
  {% endfor %}
</ul>

### Slides
<ul>
  {% for page in site.slides %}
  <li><a href="{{ page.url }}">{{ page.title }}</a></li>
  {% endfor %}
</ul>

{% include_relative _pages/about.md %}

---

**Are all links working?** Why not check with [W3C Link Checker](https://validator.w3.org/checklink?uri=marjamis.github.io&hide_type=all&depth=&check=Check).
