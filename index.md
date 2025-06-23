---
title: Home
layout: home
nav_order: 1
---

# Hi 👋

<div style="text-align:center;">
<img style="border-radius: 30px; max-width:75%" src="/assets/images/me.png"/>
<p><strong>I'm Sean.</strong></p>
</div>

## Here is my site

Click where you wanna go

<pre>
<div class="mermaid">
mindmap
  root((Sean's site))
    :::link:/#here-is-my-site
{% assign pages = site.html_pages | sort: "url" -%}
{%- for page in pages -%}
{%- assign path_parts = page.url | split: "/" -%}
{%- assign depth = path_parts | size -%}
{%- assign title = page.title | default: path_parts[depth-2] | replace: "-", " " | capitalize -%}
{%- if depth > 0 -%}
{%- assign depthX4 = depth | times: 2 -%}
{%- assign indent = "" -%}
{%- for i in (1..depthX4) -%}
{%- assign indent = indent | append: " " -%}
{%- endfor -%}
{%- capture block -%}
{{ indent }}{{ title }}
{{ indent }}:::link:{{ page.url }}
{% endcapture -%}
{{ block | nindent: 9 }}
{% endif -%}
{% endfor %}
</div>
</pre>


