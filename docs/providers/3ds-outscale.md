# 3DS OUTSCALE

> Founded in 2010 and a strategic partner of Dassault Systèmes, 3DS OUTSCALE is at the forefront of Cloud Computing infrastructure services (IaaS)

→ [outscale.com](https://outscale.com/), [GitHub](https://github.com/outscale)

## Getting started

A good starting point is the [User Guide](https://docs.outscale.com/userguide).

### Account

An Account Key (AK) and a Secret Key (SK) are needed.

### Management

* [API](https://docs.outscale.com/api) ([reference](https://docs.outscale.com/en/userguide/OUTSCALE-APIs-Reference.html), [code](https://github.com/outscale/osc-api))
* [OSC CLI](https://docs.outscale.com/en/userguide/Installing-and-Configuring-OSC-CLI.html) ([code](https://github.com/outscale/osc-cli))
* [AWS CLI](https://docs.outscale.com/en/userguide/Installing-and-Configuring-AWS-CLI.html)
* [Cockpit (web UI)](https://cockpit.outscale.com/) ([v2 (beta)](https://new.cockpit.outscale.com/), [docs](https://docs.outscale.com/en/userguide/About-Cockpit.html))

## Recipes

### Create a RKE2 cluster and install Rancher on it

* Terraform: use [Rancher Quickstart](https://github.com/rancher/quickstart/blob/master/rancher/outscale/README.md)

### Connect to a VM

* From OUTSCALE Web UI
  * In "Compute" > "VMs" (Instances in cockpit V1), click on "Create"
    * In "Security", add a rule to authorize SSH (port 22) from "My IP"
    * Copy the public IP address, download the rsa file and log in with `ssh -i ~/.ssh/outscale_xxx.rsa <public_ip> -l outscale`

### Rancher integration

* From Rancher UI
  * In "Cluster Management" > "Drivers" > "Node Drivers"
    * Select "Outscale" ([definition](https://github.com/rancher/rancher/blob/release/v2.7/pkg/data/management/machinedriver_data.go#L140)) and click on "Activate"
  * In "Cluster Management" > "Clusters"
    * In "Create" form, select "RKE2/K3s", click on "outscale"

## Ressources

### Network

* Virtual Private Clouds (VPCs)
* External IPs (EIPs)
* Flexible Network Interfaces (FNIs)
* Load Balancing Unit (LBU)
* VPN Connections
* DirectLink
* OUTSCALE Public IPs
* OUTSCALE NTP Servers

→ [docs](https://docs.outscale.com/en/userguide/Network-and-Security.html)

### Storage

* [Block Storage Unit (BSU)](https://docs.outscale.com/en/userguide/Block-Storage-Unit-(BSU).html)
* [OUTSCALE Object Storage (OOS)](https://docs.outscale.com/en/userguide/OUTSCALE-Object-Storage-(OOS).html)

### Compute

* [Flexible Compute Unit (FCU)](https://docs.outscale.com/en/userguide/Flexible-Compute-Unit-(FCU).html)
* [OUTSCALE Machine Images (OMIs)](https://docs.outscale.com/en/userguide/OUTSCALE-Machine-Images-(OMIs).html)
* [Flexible GPUs (fGPUs)](https://docs.outscale.com/en/userguide/Flexible-GPUs-(fGPUs).html)

## Open-source projects

### Kubernetes

Name                                                                                    | Installation | Documentation
----------------------------------------------------------------------------------------|--------------|-----------------------------------------------------------------------------------------------------
[BSU CSI driver](https://github.com/outscale-dev/osc-bsu-csi-driver)                    |              |
[Cloud Controller Manager](https://github.com/outscale-dev/cloud-provider-osc)          |              |
[Cluster API Provider](https://github.com/outscale-dev/cluster-api-provider-outscale)   |              | [Book](https://cluster-api-outscale.oos-website.eu-west-2.outscale.com/)
[Docker machine plugin](https://github.com/outscale-dev/docker-machine-driver-outscale) |              | [Technical guide](https://docs.outscale.com/en/userguide/Using-DockerMachine-with-3DS-OUTSCALE.html)
[RKE provisioning example](https://github.com/outscale-dev/osc-k8s-rke-cluster)         |              |
[Terraform provider](https://github.com/outscale-dev/terraform-provider-outscale)       |              | [Docs](https://registry.terraform.io/providers/outscale-dev/outscale/latest/docs)
[Rancher Driver UI](https://github.com/outscale-dev/rancher-ui-driver-outscale)         |              |

References:

* BSU: Block Storage Unit
* CAPI: Cluster API
* CCM: Cloud Controller Manager
* CSI: Container Storage Interface

### Cloud

* [Frieza](https://github.com/outscale-dev/frieza)

## Closed-source software

### Tina OS

* [TINA OS Cloud Orchestrator](https://en.outscale.com/pourquoi-outscale/tina-os-cloud-orchestrator/)
