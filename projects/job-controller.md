---
title: Job Controller
layout: home
parent: Projects
nav_order: 5
---

# [`JobDeployment` controller](https://github.com/sgatewood/job-deployment)

[![E2E Tests](https://github.com/sgatewood/job-deployment/actions/workflows/test-e2e.yml/badge.svg)](https://github.com/sgatewood/job-deployment/actions/workflows/test-e2e.yml)
[![Tests](https://github.com/sgatewood/job-deployment/actions/workflows/test.yml/badge.svg)](https://github.com/sgatewood/job-deployment/actions/workflows/test.yml)
[![Lint](https://github.com/sgatewood/job-deployment/actions/workflows/lint.yml/badge.svg)](https://github.com/sgatewood/job-deployment/actions/workflows/lint.yml)

Working on a controller to manage `Job` objects

<div class="mermaid">
flowchart TD;
    Deployment -- "manages (through ReplicaSets)" --> Pod;
    JobDeployment -- manages --> Job;
</div>

## Problem / Why

- If you change a `batch/v1` `Job`, tools like Helm fail to apply due to immutable fields. 
- I kinda wish there was a parent object like `Deployment` to recreate `Job` objects on changes (similar to how
`Deployments` recreate `Pods`)
- Of course, the better solution is often to not use `Job` objects at all
  - But sometimes with legacy code in your org this might not be an option, so it'd still be nice to have a better way to deploy them 

## [kubebuilder](https://book.kubebuilder.io/) rocks 😎

- Scaffolds the basics so you can focus on your reconciliation logic
