---
title: Awesome Tools
layout: home
parent: Awesome Lists 😎
nav_order: 1
---

# {{ page.title }}

## [FlyCut](https://apps.apple.com/us/app/flycut-clipboard-manager/id442160987?mt=12)

- Allows you to copy multiple things at once 
- I can never go back to 1 clipboard

## [Things 3](https://culturedcode.com/things/)

- Todoist but more beautiful

## [Jsonnet](https://jsonnet.org)

- Functionally define json/yaml structures
- Shall one day take over the infra world

## [`just`](https://just.systems/man/en/)

- "What we all wanted Makefiles to be"
- Or "the easiest way to make a simple dev CLI for your repo"

## [Nix Flakes](https://wiki.nixos.org/wiki/Flakes)

- Install all of your repo's tools in a hyper-reproducible nix environment

## [`direnv`](https://direnv.net/)

- Set up dev environments for specific folders

## [nixery.dev](https://nixery.dev/)

Get a docker image with any nix package by appending slashes:

```bash
docker run -it --rm nixery.dev/shell/lolcat/sl/cowsay   
```

Way better than `alpine:latest` for `kubectl debug` images

<div id="terminal-demo"></div>
<script>
  AsciinemaPlayer.create("/assets/casts/nixery.cast", document.getElementById("terminal-demo"), {
    cols: 96,
    rows: 20,
    autoPlay: true,
    loop: false,
    preload: true,
    theme: "asciinema"
  });
</script>

## ^^ [asciinema](https://docs.asciinema.org/)

Cool (and copyable) terminal recordings to embed in your website

## [asciiquarium](https://robobunny.com/projects/asciiquarium/html/)

<div id="terminal-demo2"></div>
<script>
  AsciinemaPlayer.create("/assets/casts/asciiquarium.cast", document.getElementById("terminal-demo2"), {
    cols: 214,
    rows: 45,
    autoPlay: true,
    loop: false,
    preload: true,
    theme: "asciinema"
  });
</script>
