---
title: Resume
layout: home
nav_order: 2
---

{% assign resume = site.data.resume %}
{% assign name = resume.name %}
{% assign contact = resume.contact %}

# {{ name }}

<{{contact.email}}> |
[LinkedIn]({{contact.linkedin.link}}) |
[GitHub]({{contact.github.link}})

---

{% assign education = resume.education %}

## 🎓 Education

**{{ education.school }}** ({{education.graduation}}) {{ education['school titles'] | join: ", " }}
- {{ education.degree }}. GPA {{ education.gpa }}

**Notable Courses:** {{ education['notable courses'] | join: ", " }}

---

{% assign experience = resume.experience %}

## 💼 Experience

{% for job in experience %}
### **{{ job.title }}**, {{ job.company }}
({{ job.location }}) {{ job.dates }}
{% for note in job.notes %}
- {{ note }}
{%- endfor %}
{% endfor %}

---

{% assign skills = resume.skills %}

## 💪 Skills
(non-comprehensive, in order of proficiency)

- **Languages:** {{ skills['main languages'] | join: ", " }}
- **Other technologies:** {{ skills['main other technologies'] | join: ", " }}
- **Also worked with:** {{ skills['also worked with'] | join: ", " }}

---

{% assign projects = resume.projects %}

## 💻 Projects
{% for project in projects %}
### **{% if project.link %}[{{ project.name }}]({{ project.link }}){% else %}{{ project.name }}{% endif %}**
{{ project.dates }}
- {{ project.notes | join: "\n- " }}
{% endfor %}
