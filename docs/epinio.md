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

!!! tip inline end "Tip"

    Use short name for the application name (less than 22) and do not use `-` to avoid Ingress issue (see [application name restrictions](#application-name-restrictions)).

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

!!! tip inline end "Tip"

    Delete local files before pushing the application if done from a developer workstation (see [local files restriction](#local-files-restriction)).

Language/Framework   | Path                                                                                            | Details
---------------------|-------------------------------------------------------------------------------------------------|------------------------------------------------------
Angular (TypeScript) | [devpro/epinio-samples](https://github.com/devpro/epinio-samples/tree/main/samples/angular)     | Angular Web App (Single Page Application)
.NET (C#)            | [devpro/epinio-samples](https://github.com/devpro/epinio-samples/tree/main/samples/dotnet)      | ASP.NET 7 Web API (REST), ASP.NET Web App (Razor)
Go                   | [epinio/golang-sample-app](https://github.com/epinio/epinio/tree/main/assets/golang-sample-app) |
Java                 | [spring-projects/spring-petclinic](https://github.com/spring-projects/spring-petclinic)         | Spring
JavaScript           | [ellisonleao/clumsy-bird](https://github.com/ellisonleao/clumsy-bird)                           | melonJS game engine
PHP                  | [epinio/sample-app](https://github.com/epinio/epinio/tree/main/assets/sample-app)               | phpinfo
Python               | [mageran/minio-epinio](https://github.com/mageran/minio-epinio/tree/main/samples/photo-album)   | Flask and Boto3 for the backend and Svelte for the UI
React                | [devpro/epinio-samples](https://github.com/devpro/epinio-samples/tree/main/samples/react)       | React Web App (Single Page Application)
Ruby on Rails        | [epinio/example-rails](https://github.com/epinio/example-rails)                                 |
Wordpress            | [epinio/example-wordpress](https://github.com/epinio/example-wordpress)                         | CMS written in PHP and using a MySQL database

### CLI

#### CLI cheat sheet

Command                                        | Action
-----------------------------------------------|----------------------------------------------------
`epinio app delete sample`                     | Delete an application
`epinio login -u admin 'https://<epinio_url>'` | Log in Epinio server
`epinio push --name sample --path sample-app`  | Create or update an application from a local folder
`epinio settings show`                         | Display Epinio server information

#### CLI examples

```bash
# creates an application from a remote git repository on a branch
epinio push --name dotnetapisample --git-provider github --git https://github.com/devpro/epinio-samples,feature/init-solution

# creates an application from a remote git repository
epinio push --name clumsybird --git-provider github --git https://github.com/ellisonleao/clumsy-bird
```

### Helm chart

* [devpro/helm-charts](https://github.com/devpro/helm-charts/blob/main/charts/epinio/README.md) encapsulates Epinio Helm chart and provides concrete example of installation and use

### Local cluster with K3D

* [mesquitamv/epinio-deploy](https://github.com/mesquitamv/epinio-deploy)

### Limitations

#### Application name restrictions

* **Max length**: There is an issue with Ingress if the application name is too long
(reproduced with raspnetwebrazorsample which generated a service name like raspnetwebrazorsample-40251af7269c59d923bfa391bc241c7a320d332c, of 63 characters).
* **Special characters**: Avoid special character like `-`

### Local files restriction

Currently, there is no way to ignore local folders and files when pushing an application. This is a serious issue while working on a codebase using NPM packages because node_modules can easily be heavy.

This limitation is tracked by [Issue #2589](https://github.com/epinio/epinio/issues/2589).
