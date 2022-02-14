# Everything and anything...

## Core areas of focus

| Programming Languages | Platforms | Cloud | Additional areas |
| --- | --- | --- | --- |
| Go | Kubernetes | AWS | DevOps, CI/CD, all the buzz words |
| Python | ECS  | GCP | Security |
| Javascript | Containers | | Networking |
| | | | Observability |

## Posts

### Last 10 Posts (most recent first)

<ol>
  {% for post in site.posts offset: 0 limit: 10 %}
  <li>{{ post.date}} - <a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ol>


### Categories

<ul>
  {% for category in site.categories %}
  <li><a href="{{ site.url }}/category/{{ category | first | url_encode }}.html">{{ category | first | capitalize }}</a></li>
  {% endfor %}
</ul>

## Pages

{% include page_dir_listing.md loc="documentation" %}

{% include page_dir_listing.md loc="guides" %}

{% include page_dir_listing.md loc="misc" %}

## Slides

<ul>
  {% for page in site.slides %}
  <li><a href="{{ page.url }}">{{ page.title }}</a></li>
  {% endfor %}
</ul>

{% include about.md %}

---

**Are all links working?** Why not check with [W3C Link Checker](https://validator.w3.org/checklink?uri=marjamis.github.io&hide_type=all&depth=&check=Check).
