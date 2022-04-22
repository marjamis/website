{% if site.categories[page.category] %}
<ol>
    {% for post in site.categories[page.category] %}
    <li>{{ post.date}} - <a href="{{ post.url }}">{{ post.title }}</a></li>
    {%- endfor %}
</ol>
{% else %}
No posts currently...
{% endif %}
