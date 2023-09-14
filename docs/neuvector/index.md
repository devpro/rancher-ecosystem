# NeuVector

> NeuVector delivers Full Lifecycle Container Security with the only cloud-native, Kubernetes security platform providing end-to-end vulnerability management, automated CI/CD pipeline security,
> and complete run-time security including the industry’s only container firewall to protect your infrastructure from zero days and insider threats.

→ [neuvector.com](https://neuvector.com/) ([docs](https://docs.neuvector.com/), [GitHub](https://github.com/neuvector/neuvector), [FAQ](https://neuvector.com/wp-content/uploads/2019/05/NeuVector-Customer-FAQ.pdf))

## Content

* [Architecture](architecture.md)

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

* Protect data with Data Loss Prevention (DLP)
    * [How to Protect Sensitive Data in Containers with Container DLP](https://blog.neuvector.com/article/protect-sensitive-data-with-container-dlp)

* Service Mesh integration
    * [How to Secure Containers in a Service Mesh such as Istio and Linkerd2](https://neuvector.com/videos/secure-containers-in-service-mesh-istio/)

* Automation
    * [REST API and Automation](https://open-docs.neuvector.com/automation/automation)

## Trainings

* NeuVector Rodeo

* [NeuVector Youtube channel](https://www.youtube.com/channel/UCpAoVOdUS0i7T92cszeRVoQ)
    * [NeuVector - 101 (Fall 2021)](https://www.youtube.com/watch?v=9ihaBr_QGzQ)
    * [NeuVector Minute - Installing NeuVector on Rancher](https://www.youtube.com/watch?v=cc8nA7nxuDc) - Nov 12, 2020
    * [Zero-Trust Security for Kubernetes and Container Workloads](https://www.youtube.com/watch?v=SzNbJ7W3Mik) - March 29, 2022

## Versions

### v5

* New scanning targets
* Zero-drift process and file protection
* Split policy mode
* Web app firewall rule detection
* CRD updates
* Enhanced Rancher Integration
* Automated promotion of group nodes

## Scanning

### GitLab

* [Scan for Vulnerabilities during Gitlab Build Pipeline](https://docs.neuvector.com/scanning/build/gitlab)

## Installation

### Rancher App

* In Rancher, from your cluster, go to Apps > Charts and look for NeuVector and click on Install
* In Step 2 > Edit Options
    * In Container Runtime, make sure you select the right runtime (containerd for instance with AKS)
    * In Ingress Configuration, check the Manager Ingress Status box, fill Manager Ingress Host (neuvector.demo for example)
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

## Q&A

Question | Answer
-------- | ------
It is possible to export reports and scans in pdf and automate the creation sending them via email for example? | Yes, this could be done by leveraging the API
Tt is possible to customize login UI? | The name can be changed but no other customization for the moment (a feature request has been created to cover this part)
Must NeuVector be installed into each working cluster or is it possible to have one central NeuVector cluster and route to it from each downstream cluster? | The components such as the scanner, enforcer, etc. must be installed in each cluster but you can federate clusters together so there's a single UI to manage multiple clusters
Can we "ignore/silence" a vulnerability so it doesn't show in the reporting? | You can "accept" vulnerabilities that negate them coming up in reports/alerts, reports can also filter out vulnerabilities with (for example) a low CVE score, No fix, etc. so you could generate a list of all known CVE's in your environment, filter by no fix and then bulk accept those
How much of a performance overhead is the enforcer? | This is documented in the [FAQ](https://neuvector.com/wp-content/uploads/2019/05/NeuVector-Customer-FAQ.pdf) at point 2

## Known issues

* Timeout while on the web interface
    * Refresh the page and authenticate again

## Recipes

### How to scan control plane nodes

By default, only worker nodes are scanned. You can change this by adapting the tolerations of the enforcer when installing NeuVector.
The default can be seen in [values.yaml](https://github.com/neuvector/neuvector-helm/blob/master/charts/core/values.yaml) (enforcer / tolerations).
Depending on the Kubernetes distribution, the taints may be different on non-worker nodes.

To tolerate all possible taints, a config would be:

```yaml
enforcer:
  tolerations:
    - operator: "Exists"
```

## Integrations

### Harbor

* [Installing and Configuring NeuVector Harbor Registry Adapter](https://github.com/rancher/barn/blob/main/Walkthroughs/NeuVector/Harbor%20Adapter%20Configuration/README.md)
