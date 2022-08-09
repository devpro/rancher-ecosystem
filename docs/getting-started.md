# Getting started with Rancher

Make sure your working environment meets the [requirements](requirements.md).

## Quick start

This first installation starts with the official [rancher.com/quick-start](https://rancher.com/quick-start):

* Run Rancher locally with Docker (see official documentation [Installing Rancher on a Single Node Using Docker](https://rancher.com/docs/rancher/v2.6/en/installation/other-installation-methods/single-node-docker/))

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
  * Take a look at the version (Rancher 2.6 brings many interesting features and a new UI)
  * There is already a local cluster (the cluster running Rancher!)
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
