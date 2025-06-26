---
title: flake-utils
layout: home
parent: Projects
nav_order: 6
---

# [flake-utils](https://github.com/sgatewood/flake-utils)

My own lil version of:

```nix
flake-utils.url = "github:numtide/flake-utils"
```

So far I've only add one utility: `pkgVersionSnapshotTest` to make my `nix flake update`
[PRs](https://github.com/sgatewood/k3d/pull/4/files) include a diff of all the tools upgraded

## Background

When you create a PR for the result of `nix flake update`, nobody can tell what versions of our `pkgs` changed.

What I wanted was a snapshot test to add that diff to your [PR](https://github.com/sgatewood/k3d/pull/4/files):

```diff
diff --git a/flake.lock.pkgs.yaml b/flake.lock.pkgs.yaml
index d051785..af92952 100644
--- a/flake.lock.pkgs.yaml
+++ b/flake.lock.pkgs.yaml
@@ -1,18 +1,18 @@
 fzf:
-  changelog: https://github.com/junegunn/fzf/blob/v0.59.0/CHANGELOG.md
+  changelog: https://github.com/junegunn/fzf/blob/v0.62.0/CHANGELOG.md
   description: Command-line fuzzy finder written in Go
   homepage: https://github.com/junegunn/fzf
-  name: fzf-0.59.0
-  version: 0.59.0
+  name: fzf-0.62.0
+  version: 0.62.0
 just:
-  changelog: https://github.com/casey/just/blob/1.39.0/CHANGELOG.md
+  changelog: https://github.com/casey/just/blob/1.40.0/CHANGELOG.md
   description: Handy way to save and run project-specific commands
   homepage: https://github.com/casey/just
-  name: just-1.39.0
-  version: 1.39.0
+  name: just-1.40.0
+  version: 1.40.0
 k3d:
-  changelog: https://github.com/k3d-io/k3d/blob/v5.8.2/CHANGELOG.md
+  changelog: https://github.com/k3d-io/k3d/blob/v5.8.3/CHANGELOG.md
   description: Helper to run k3s (Lightweight Kubernetes. 5 less than k8s) in a docker container
   homepage: https://github.com/k3d-io/k3d/
-  name: k3d-5.8.2
-  version: 5.8.2
+  name: k3d-5.8.3
+  version: 5.8.3
```

This helps you set up a nix **app** and a nix **check** to implement this snapshot test

- the **check** is the test that fails if you don't update the snapshot
- the **app** updates the snapshot

### how to add `pkgVersionSnapshotTest` to your nix flake

First set up one of your `let` variables to evaluate the library:

```nix
pkgVersionSnapshotTest = sean-flake-utils.lib.pkgVersionSnapshotTest {
  inherit pkgs;
  inherit devShell;
  snapshotFileName = "flake.lock.pkgs.yaml";
  snapshotFileDir = ./.;
};
```

Then create the check & app in your outputs:

```nix
checks.pkgVersionSnapshotTest = pkgVersionSnapshotTest.check;
apps.pkgVersionSnapshotTestUpdate = pkgVersionSnapshotTest.updateApp;
```

To run your checks:

```bash
nix flake check
```

To run the update app:

```bash
nix run .#pkgVersionSnapshotTestUpdate
```
