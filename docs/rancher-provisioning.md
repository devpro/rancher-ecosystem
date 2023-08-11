# Resource provisioning

## General features

* [Launching Kubernetes with Rancher](https://docs.ranchermanager.rancher.io/pages-for-subheaders/launch-kubernetes-with-rancher)
* [Cluster Management Resources](https://rancher.github.io/dashboard/code-base-works/cluster-management-resources)

## Provisioning logic

💡 Rancher v2.6.0 introduces V2 cluster provisioning that leverages [CAPI](https://cluster-api.sigs.k8s.io/) resources including Clusters and MachineDeployments to define and manage the desired state of downstream RKE2 and K3s clusters

### Drivers

From Rancher UI, drivers can be viewed and managed from **Cluster Management > Drivers page**.

#### Cluster drivers

Operators are used for built-in cluster drivers, for example [AKS operator](https://github.com/rancher/aks-operator), [EKS operator](https://github.com/rancher/eks-operator), [GKE operator](https://github.com/rancher/gke-operator).

See also: [Kontainer Engine Example Driver](https://github.com/rancher-plugins/kontainer-engine-driver-example)

#### Node drivers

Drivers are [docker-machine](https://github.com/docker/machine) implementations for each provider, whether for RKE or RKE2/K3s. It is an API to create and delete VMs.

Built-in node drivers are defined in [rancher/machine](https://github.com/rancher/machine/tree/master/drivers).

Additional node drivers are added in [rancher/rancher](https://github.com/rancher/rancher/blob/release/v2.7/pkg/data/management/machinedriver_data.go#L74).

See also: [UI DevKit > Machine Drivers](https://rancher.github.io/dashboard/code-base-works/machine-drivers)

### Templates (V1 provisioning)

In V1 provisioning, clusters have nodes, nodePools, and nodeTemplates.

#### Node Templates (V1 provisioning)

Node templates make it possible to reuse machine configs for RKE1 provisioning.

### Templates (V2 provisioning)

In V2 provisioning, clusters have [Machines](https://cluster-api.sigs.k8s.io/user/concepts.html#machine) which are instances of MachineTemplates and have a specific configuration for each infrastructure provider.

#### MachineTemplates

#### Cluster templates

> Cluster templates encompass both Kubernetes configuration and node pool configuration, allowing a single template to contain all the information Rancher needs to provision new nodes in a cloud provider and install Kubernetes on those nodes. (ref. [How-to Guides > New User Guides > Manage Clusters](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/manage-clusters/manage-cluster-templates))

Currently (August 2023) examples are only provided for RKE2.

See also: [devpro/helm-charts](https://github.com/devpro/helm-charts/tree/main/charts/rancher-cluster-templates), [Kubernetes Master Class: Creating RKE2 Cluster Templates](https://youtu.be/xXtOP7CHbSA)).

### Kubernetes distribution specifics

#### RKE

Rancher uses custom CRDs to create clusters and custom controllers that will be used with docker-machine drivers.

Node templates are used to ease cluster creation.

RKE1 cluster template exist but doesn't allow node pool configuration or RBAC.

#### RKE2/K3s

RKE2/K3s cluster creation uses [Povisioning V2](https://github.com/rancher/rancher/tree/release/v2.7/pkg/controllers/provisioningv2)

Rancher uses the Cluster API controllers and CRDs internally. But it wraps its own Cluster and other CRDs around it to make it "easier to use" and maybe add additional features necessary for Rancher. Rancher then bundles its own RKE2 Cluster API provider, which uses the same docker machine drivers to create and delete VMs.

When a Cluster (provisioning.cattle.io/v1) is created, various CAPI objects are generated: RKECluster, RKEControlPlane, Cluster, RKEBootstrapTemplate, MachineDeployment and infra specific kinds like Amazonec2MachineTemplate.

Currently (January 2023) it is not easily possible to use other Cluster API providers with Rancher.
