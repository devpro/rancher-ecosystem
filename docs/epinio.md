# Epinio

> Tame your developer workflow to go from Code to URL in one push.

:octicons-cross-reference-24: **Links:**
[:material-web: epinio.io](https://epinio.io/),
[:fontawesome-solid-book: docs](https://docs.epinio.io/),
[:simple-github: repository](https://github.com/epinio/epinio)

## Getting started

### Introduction

Epinio addresses the wish to hide all the complexity of building and deploying code. This subject was adressed before by Cloud Foundry, which got depecrated with the rise of Kubernetes.

Epinio is Cloud Native, free, open-source, simple solution that runs in a Kubernetes cluster. Its development is lead by SUSE.

### Quick start

* Make sure you have a Kubernetes cluster to work on and you are connected (by executing `kubectl config current-context` in a terminal for example)
* Follow [Epinio official quickstart](https://docs.epinio.io/tutorials/quickstart)

### Presentations

* Youtube videos
    * [SUSECON - Customize your Developer Experience with Epinio](https://www.youtube.com/watch?v=cr4vWO9J7tk) - October 8, 2022
    * [SUSE Projects - Epinio demo: Wordpress on Digital Ocean](https://www.youtube.com/watch?v=OdPF0qH5Pf8&t=296s) - July 6, 2021
    * [Kubesimplify - Let's Learn Epinio](https://www.youtube.com/watch?v=ietNQSQXhAc) - June 23, 2021
    * [SUSECON - Epinio Demo: Building a PaaS on Kubernetes using off-the-shelf components](https://www.youtube.com/watch?v=HKXtAgh3ILw) - November 10, 2021

## Going further

### Application examples

* [mageran/minio-epinio](https://github.com/mageran/minio-epinio/tree/main/samples/photo-album): Python with Flask and Boto3 for the backend and Svelte for the UI
* [epinio/example-rails](https://github.com/epinio/example-rails): Ruby on Rails

### CLI cheat sheet

Command                                       | Action
----------------------------------------------|--------------------------------
`epinio push --name sample --path sample-app` | Create or update an application
`epinio app delete sample`                    | Delete an application

### Helm chart

* [devpro/helm-charts](https://github.com/devpro/helm-charts/blob/main/charts/epinio/README.md) encapsulates Epinio Helm chart and provides concrete example of installation and use

### Local cluster with K3D

* [mesquitamv/epinio-deploy](https://github.com/mesquitamv/epinio-deploy)
