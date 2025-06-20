---
title: Pulumi contribution
layout: home
parent: Dev Stories
nav_order: 1
---

# The `PULUMI_STACK` variable

This is the story of a [small open-source contribution](https://github.com/pulumi/pulumi/pull/18717) I made to Pulumi 🎉

## What we wanted

- My team loves using [direnv](https://direnv.net/) to select between deployment environments using directories. 
  - `cd deployment/clusters/dev` --> magically your `kubectl` is configured for the dev cluster
- We wanted to use this same approach to select which pulumi stack `pulumi` is pointed to
  - `cd deployment/pulumi/stacks/network` --> `pulumi up` deploys the network stack
- Otherwise, you have to pass in your stack each time with `-s` (e.g. `pulumi up -s network -r ...`)
  - (or else it would just give you an interactive selection menu to pick each time, which gets tiring when you're applying a lot)
- There was also `pulumi stack select` which is a bit like using `kubectl config set-context --current --namespace=...` to avoid the `-n` on every command
  - But when you're talking about infrastructure stacks, you really want it to be obvious which stack you are deploying (even though the diff stage is a bit of a failsafe)

## The problem

- Surprisingly, the `--stack` flag didn't have any env variable support ❌
  - We also [appeared](https://github.com/pulumi/pulumi/issues/13550) to not be the only ones who wanted this

## The solution

- This seemed small enough to just take some initiative and propose as an [open-source PR](https://github.com/pulumi/pulumi/pull/18717)
  - I just had to read up on [how to contribute / how to test my changes](https://github.com/pulumi/pulumi/blob/master/CONTRIBUTING.md)
  - And then, of course, overdo it a bit on the PR description to make it super easy to review 😎
  
## Impact

- Today, if you check <https://www.pulumi.com/docs/iac/cli/environment-variables> you will see that the `PULUMI_STACK` variable is supported 🎉
  - Once this came down the nix flake pipes, we were able to use direnv like we wanted to 💯
