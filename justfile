# (default recipe -- show available recipes)
help:
  @just -l

_border:
  #!/usr/bin/env bash
  set -euo pipefail

  screen_width=$(tput cols)
  echo -en '{{BOLD}}{{MAGENTA}}'
  printf '=%.0s' $(seq 1 "${screen_width}")
  echo -en '{{NORMAL}}'

bundle-clean:
  rm -rf "${REPO_ROOT}/.gem"

bundle-install:
  bundle config set --local path "${REPO_ROOT}/.gem"
  bundle install

open:
  open http://127.0.0.1:4000

run-dev:
  just bundle-install
  (sleep 2 && just open) &
  bundle exec jekyll serve --livereload
