---
title: Metrics exporter
layout: home
parent: Dev Stories
nav_order: 2
---

# {{ page.title }}

I think this is a good example of "small effort, big impact"

## Background

- We were running a service in K8s that we didn't own 
  - (all changes would have needed open-source contributions)
- We wanted a couple of **custom metrics** that were not supported by this application yet
  - We wanted a quick way to add these, and if possible have a **programmatic environment** to add such things (sentiment one tends to get when working exclusively at the manifest level with blackbox docker images)

## Solution

- I just made an [exporter](https://prometheus.io/docs/instrumenting/exporters/) microservice using Go
  - The Prometheus APIs make it really easy to expose such metrics for scraping into datadog, grafana, etc
  - i.e. as long as you can figure out the **metric values**, publishing them is very easy
- To calculate the values for the additional things I wanted to monitor, I just had to hit this application's APIs
  - Luckily they had a public OpenAPI schema, so I was able to use [openapi-generator](https://openapi-generator.tech/) to generate typed Go code for their APIs
    - e.g. `myTypedStuff, err := myClient.potatoAPI.ListImportantPotatoes(ctx).Execute()`
    - not `resp, err := http.Get("http://potato-api.potato-namespace.cluster.local/api/v0/important-potatoes")`

<div class="mermaid">
flowchart LR;
  subgraph "k8s cluster";
    datadog-agent -- scrapes --> me["metrics-exporter:8080/metrics"];
    me -- talks to --> potato-api;
  end;
  datadog-agent -- publishes to --> datadog;
  style me fill:#10ed00,stroke:#333,stroke-width:2px;
</div>

## Impact

- We were able to monitor the additional pieces we wanted 
  - These were actually **mission critical** signals that prod was working
  - Our alerts around these metrics actually caught a few issues in lower environments
- We also had a programmatic environment flexible enough for any other metrics we wanted to add moving forward
