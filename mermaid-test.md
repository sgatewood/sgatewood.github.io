---
title: Mermaid test
layout: home
nav_order: 99
---

{% raw %}

The plan:
<div class="mermaid">
flowchart TD;
    a["get mermaid graphs working"] --> b["do something with it"];
</div>

dark mode:
<pre>
<div class="mermaid">
%%{ init: { "theme": "dark" } }%%
mindmap
  root((site))
    Origins
      Long history
      ::icon(fa fa-book)
      Popularisation
        British popular psychology author Tony Buzan
    Research
      On effectiveness<br/>and features
      On Automatic creation
        Uses
            Creative techniques
            Strategic planning
            Argument mapping
    Tools
      Pen and paper
      Mermaid
</div>
</pre>

{% endraw %}

