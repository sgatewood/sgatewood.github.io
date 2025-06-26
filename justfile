set export := true

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

build baseurl:
  just bundle-install
  bundle exec jekyll build --baseurl "${baseurl}"

nix-check:
  nix flake check

nix-check-update:
  nix fmt
  nix run .#pkgVersionSnapshotTestUpdate

nix-flake-update:
  nix flake update --commit-lock-file
  just nix-check-update
