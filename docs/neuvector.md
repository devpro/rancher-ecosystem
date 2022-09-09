# NeuVector

> NeuVector delivers Full Lifecycle Container Security with the only cloud-native, Kubernetes security platform providing end-to-end vulnerability management, automated CI/CD pipeline security, and complete run-time security including the industry’s only container firewall to protect your infrastructure from zero days and insider threats.

→ [neuvector.com](https://neuvector.com/)

## Features

* Automated _Behavioral-Based_ Zero-Trust modes
  * Discover
  * Monitor
  * Protect

* Continuously watches every packet
  * Layer 3
  * Layer 4
  * Layer 7

* Network traffic to the source of truth

* Security-as-Code for replicating Zero-Trust Segmentation
  * [neuvector.com/videos](https://neuvector.com/videos/the-neuvector-minute-security-policy-as-code/)

## Training

* [NeuVector Youtube channel](https://www.youtube.com/channel/UCpAoVOdUS0i7T92cszeRVoQ)
  * [NeuVector-101 (Fall 2021)](https://www.youtube.com/watch?v=9ihaBr_QGzQ)

## Architecture

### Kubernetes objects

* Controller
  * Manage policies REST API
* Scanner
* Web UI
  * Manager User Interface
  * CLI tool
* Enforcer (DaemonSet)
  * Enforce Securities Policies
  * Inspect Network Traffic

## Versions

### v5

* New scanning targets
* Zero-drift process and file protection
* Split policy mode
* Web app firewall rule detection
* CRD updates
* Enhanced Rancher Integration
* Automated promotion of group nodes

## Installation

### Rancher App

* In Rancher, from your cluster, go to Apps > Charts and look for NeuVector and click on Install
* In Step 2 > Edit Options
  * In Container Runtime, make sure you select the right runtime (containerd for instance with AKS)
  * In Ingress Configuration, check the Manager Ingress Status box, fille Manager Ingress Host (neuvector.demo for example)
* In Step 2 > Edit YAML, edit the content to add ingressClassName

  ```bash
  manager:
    ingress:
      annotations:
        nginx.ingress.kubernetes.io/backend-protocol: HTTPS
      enabled: true
      host: neuvector.demo
      ingressClassName: nginx
      path: /
      secretName: null
      tls: false
  ```

* Click on Install and review the overall installation process
* Once installed correctly (all pods running fine), go to Service Discovery > Ingresses
  * In `cattle-neuvector-system` namespace, click on the target link
  * Log in with admin/admin and update immediatly the password
