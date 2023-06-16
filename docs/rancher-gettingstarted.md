# Getting started with Rancher

## Quick start

To have a quick look at Rancher UI, follow the procedure given at [rancher.com/quick-start](https://www.rancher.com/quick-start#getstarted-1). More details on [Installing Rancher on a Single Node Using Docker](https://ranchermanager.docs.rancher.com/pages-for-subheaders/rancher-on-a-single-node-with-docker) documentation.

* Open a terminal and use Docker CLI to run Rancher container

```bash
# starts container
sudo docker run --name local_rancher --privileged -d --restart=unless-stopped -p 3001:443 rancher/rancher
# kicks off rancher
curl -k -L https://localhost:3001/dashboard
# gets generated password
sudo docker logs local_rancher 2>&1 | grep "Bootstrap Password:"
```

* Open local [Rancher dashboard](https://localhost:3001/dashboard)
  * Enter with the login copied in the previous steps
  * There is already a `local` cluster (the cluster running Rancher)
  * Rancher container runs a local Kubernetes cluster with k3s

  ```bash
  sudo docker exec -it local_rancher ps -ef
  ```

  * Review the feature flags and the values by default
  * Download or copy the kubeconfig and merge it with your local one
  * Inspect the running containers

  ```bash
  kubectl get pods -A
  ```

  * Helm has been used to install fleet and webhooks

  ```bash
  helm list --all-namespaces
  ```

## Quick starts

* [Quickstart examples for the SUSE Rancher product portfolio](https://github.com/rancher/quickstart)

## Getting further

* [Rancher Barn](https://github.com/rancher/barn)
