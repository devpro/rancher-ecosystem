# Getting started with Rancher

## Quick start

### Run Rancher with Docker

To have a quick look at Rancher UI, follow the procedure given at [rancher.com/quick-start](https://www.rancher.com/quick-start#getstarted-1). More details on [Installing Rancher on a Single Node Using Docker](https://ranchermanager.docs.rancher.com/pages-for-subheaders/rancher-on-a-single-node-with-docker) documentation.

* Open a terminal and use Docker CLI to run Rancher container

```bash
# starts Rancher container
docker run --name local_rancher --privileged -d --restart=unless-stopped -p 3001:443 rancher/rancher
# waits few seconds to make sure Rancher is running
curl -k -L https://localhost:3001/dashboard
# gets the generated password
docker logs local_rancher 2>&1 | grep "Bootstrap Password:"
# prints the processes running in Rancher container (k3d, containerd, coredns, rancher in particular)
docker exec -it local_rancher ps -ef
```

* Open local [Rancher dashboard](https://localhost:3001/dashboard)
  * Ignore the invalid certificate warning
  * Login the password copied in the previous steps
  * Set the password that you want, agree with terms and conditions and click on Continue
  * You are now on Rancher home page! Here you see the list of Kubernetes clusters managed by Rancher
  * Click on the `local`, which is the one running Rancher
  * Explore the UI with on the left the menu to access all Kubernetes resources, on the top specific actions and the user menu
  * Open a Kubectl shell and inspect the running containers

  ```bash
  # inspects the running container
  kubectl get pods -A
  # displays the applications installed by Helm (fleet and webhooks)
  helm list --all-namespaces
  ```

* Use the terminal to clean resources

```bash
# stops Rancher container
docker stop local_rancher
# delete Rancher container
docker rm local_rancher
```
