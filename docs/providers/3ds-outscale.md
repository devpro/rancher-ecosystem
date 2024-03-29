# 3DS OUTSCALE

> Founded in 2010 and a strategic partner of Dassault Systèmes, 3DS OUTSCALE is at the forefront of Cloud Computing infrastructure services (IaaS).

:octicons-cross-reference-24: **Links:** [:material-web: outscale.com](https://outscale.com/), [:simple-github: organization](https://github.com/outscale)

## Getting started

A good starting point is the [User Guide](https://docs.outscale.com/userguide).

### Account

An _Account Key_ and a _Secret Key_ are needed to authenticate and manage the resources on OUTSCALE Cloud.

### Management

* [API](https://docs.outscale.com/api) ([reference](https://docs.outscale.com/en/userguide/OUTSCALE-APIs-Reference.html), [code](https://github.com/outscale/osc-api))
* [OSC CLI](https://docs.outscale.com/en/userguide/Installing-and-Configuring-OSC-CLI.html) ([code](https://github.com/outscale/osc-cli))
* [AWS CLI](https://docs.outscale.com/en/userguide/Installing-and-Configuring-AWS-CLI.html)
* [Cockpit (web UI)](https://cockpit.outscale.com/) ([v2 (beta)](https://new.cockpit.outscale.com/), [docs](https://docs.outscale.com/en/userguide/About-Cockpit.html))
* [Visual Studio Extension](https://marketplace.visualstudio.com/items?itemName=outscale.osc-viewer) ([code](https://github.com/outscale/vscode-osc-viewer))

## Recipes

### Create a Kubernetes cluster from OSC VMs and install Rancher on it

* Terraform: use [Rancher Quickstart](https://github.com/rancher/quickstart/blob/master/rancher/outscale/README.md)

### Connect to a OSC VM

* From OUTSCALE Web UI
    * In "Compute" > "VMs" (Instances in cockpit V1), click on "Create"
        * In "Security", add a rule to authorize SSH (port 22) from "My IP"
        * Copy the public IP address, download the rsa file and log in with `ssh -i ~/.ssh/outscale_xxx.rsa <public_ip> -l outscale`

### Create a Kubernetes Rancher on OCS VMs from Rancher

* From Rancher UI
    * In "Cluster Management" > "Drivers" > "Node Drivers"
        * Select "Outscale" ([definition](https://github.com/rancher/rancher/blob/release/v2.7/pkg/data/management/machinedriver_data.go#L140)) and click on "Activate"
    * In "Cluster Management" > "Clusters"
        * In "Create" form, select "RKE2/K3s", click on "outscale"

### RKE2 creation from Rancher UI

* Open Rancher
    * In "Cluster Management", "Drivers", "Node Drivers", enable "Outscale"
    * In "Cluster Management", "Cloud Credentials", click on "Create", select "Outscale", submit and fill the informations
    * In "Cluster Management", "Clusters", click on "Create", select "outscale"
        * Specify the "supportOmi" (check [Official OMIs Reference](https://docs.outscale.com/en/userguide/Official-OMIs-Reference.html))
        * Set "tinav5.c3r4p1" as "instanceType" (check [Instance Types](https://docs.outscale.com/en/userguide/Instance-Types.html))

### RKE2 troubleshooting

* Open Rancher
    * In "Cluster Management", "Clusters", click on the cluster, in the Machine Pool line click on the menu and select "Download SSH Key"

* Open [new.cockpit.outscale.com](https://new.cockpit.outscale.com/)
    * In "Compute", "VMs", in the VM line, copy the "Public IP" value

* Open a terminal

```bash
# makes sure ssh files have the right permission
chmod 600 /path/to/ssh
# connects to the VM
ssh -i /path/to/ssh/id_rsa <public_ip> -l outscale
# example: ssh -i /mnt/c/Users/SomeUser/workspace/temp/osc-dummy01-pool1-xxxxxx-yyyy/id_rsa 1.2.3.4 -l outscale
```

* Investigate potential issues

```bash
journalctl -xefu rke2-server
systemctl status rke2-server
journalctl -u rancher-system-agent.service -f

# installs kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

sudo cp /etc/rancher/rke2/rke2.yaml .
sudo chown outscale:outscale rke2.yaml
export KUBECONFIG=/home/outscale/rke2.yaml
kubectl get pods --all-namespaces
```

## Ressources

### Network

* Virtual Private Clouds
* External IPs
* Flexible Network Interfaces
* Load Balancing Unit
* VPN Connections
* DirectLink
* OUTSCALE Public IPs
* OUTSCALE NTP Servers

Ref. [docs](https://docs.outscale.com/en/userguide/Network-and-Security.html)

### Storage

* [Block Storage Unit](https://docs.outscale.com/en/userguide/Block-Storage-Unit-BSU.html)
* [OUTSCALE Object Storage](https://docs.outscale.com/en/userguide/OUTSCALE-Object-Storage-OOS.html)

### Compute

* [Flexible Compute Unit](https://docs.outscale.com/en/userguide/Flexible-Compute-Unit-FCU.html)
* [OUTSCALE Machine Images](https://docs.outscale.com/en/userguide/OUTSCALE-Machine-Images-OMIs.html)
* [Flexible GPUs](https://docs.outscale.com/en/userguide/Flexible-GPUs-fGPUs.html)

## Open-source projects

### Kubernetes

Name                                                                                | Links
------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------
[BSU CSI driver](https://github.com/outscale/osc-bsu-csi-driver)                    |
[Cloud Controller Manager](https://github.com/outscale/cloud-provider-osc)          |
[Cluster API Provider](https://github.com/outscale/cluster-api-provider-outscale)   | [Book](https://cluster-api-outscale.oos-website.eu-west-2.outscale.com/)
[Docker machine plugin](https://github.com/outscale/docker-machine-driver-outscale) | [Technical guide](https://docs.outscale.com/en/userguide/Using-DockerMachine-with-3DS-OUTSCALE.html)
[RKE provisioning example](https://github.com/outscale/osc-k8s-rke-cluster)         |
[Terraform provider](https://github.com/outscale/terraform-provider-outscale)       | [Docs](https://registry.terraform.io/providers/outscale/outscale/latest/docs)
[Rancher Driver UI](https://github.com/outscale/rancher-ui-driver-outscale)         |

#### Cloud Controller Manager

* Install from Helm ([code](https://github.com/outscale/cloud-provider-osc/tree/OSC-MIGRATION/deploy/k8s-osc-ccm), [ArtifactHub](https://artifacthub.io/packages/helm/osc-cloud-controller-manager/osc-cloud-controller-manager))

```bash
helm install my-osc-cloud-controller-manager oci://registry-1.docker.io/outscalehelm/osc-cloud-controller-manager
```

* Use annotations ([examples](https://github.com/outscale/cloud-provider-osc/tree/OSC-MIGRATION/examples))

```yaml
# Service example
apiVersion: v1
metadata:
  annotations:
    service.beta.kubernetes.io/osc-load-balancer-name-length: "20"
    service.beta.kubernetes.io/osc-load-balancer-name: "simple-lb-test"
```

#### Container Storage Interface

TODO

### Cloud

* [Frieza](https://github.com/outscale/frieza)

## Closed-source software

### Tina OS

* [TINA OS Cloud Orchestrator](https://en.outscale.com/pourquoi-outscale/tina-os-cloud-orchestrator/)

## Glossary

Name | Meaning
-----|----------------------------
AK   | Account Key
BSU  | Block Storage Unit
CAPI | Cluster API
CCM  | Cloud Controller Manager
CSI  | Container Storage Interface
EIP  | External IP
FCU  | Flexible Compute Unit
fGPU | Flexible GPU
FNI  | Flexible Network Interface
GPU  | Graphics Processing Units
LBU  | Load Balancing Unit
OMI  | OUTSCALE Machine Image
OOS  | OUTSCALE Object Storage
OSC  | OUTSCALE Cloud
SK   | Secret Key
VPC  | Virtual Private Clouds
