# Resource provisioning

## General documentation

* [Launching Kubernetes with Rancher](https://docs.ranchermanager.rancher.io/pages-for-subheaders/launch-kubernetes-with-rancher)
* [Cluster Management Resources](https://github.com/rancher/dashboard/blob/master/docusaurus/docs/code-base-works/cluster-management-resources.md)

## Infrastructure providers

* [3DS OUTSCALE Cloud](providers/3ds-outscale.md)
* [Amazon AWS](providers/amazon-aws.md)
* [Google GCP](providers/google-gcp.md)
* [Microsoft Aure](providers/microsoft-azure.md)
* [Nutanix](providers/nutanix.md)
* [VMware vSphere](./providers/wmware-vsphere.md)

## Provisioning logic

### Drivers

From Rancher UI, drivers can be viewed and managed from **Cluster Management > Drivers page**.

#### Cluster drivers

Operators are used for built-in cluster drivers, for example [AKS operator](https://github.com/rancher/aks-operator), [EKS operator](https://github.com/rancher/eks-operator), [GKE operator](https://github.com/rancher/gke-operator).

See also: [Kontainer Engine Example Driver](https://github.com/rancher-plugins/kontainer-engine-driver-example)

#### Node drivers

Built-in node drivers are defined in [rancher/machine](https://github.com/rancher/machine/tree/master/drivers).

Additional node drivers are added in [rancher/rancher](https://github.com/rancher/rancher/blob/release/v2.7/pkg/data/management/machinedriver_data.go#L74).

Drivers are [docker-machine](https://github.com/docker/machine) implementations for each provider, whether for RKE or RKE2/K3s. It is an API to create and delete VMs.

See also: [UI DevKit > Machine Drivers](https://rancher.github.io/dashboard/code-base-works/machine-drivers)

### Distributions

#### RKE

Rancher uses custom CRDs to create clusters and custom controllers that will be used with docker-machine drivers.

Node templates are used to ease cluster creation.

#### RKE2/K3s

RKE2/K3s cluster creation uses [Povisioning V2](https://github.com/rancher/rancher/tree/release/v2.7/pkg/controllers/provisioningv2)

Rancher uses the Cluster API controllers and CRDs internally. But it wraps its own Cluster and other CRDs around it to make it "easier to use" and maybe add additional features necessary for Rancher. Rancher then bundles its own RKE2 Cluster API provider, which uses the same docker machine drivers to create and delete VMs.

When a Cluster (provisioning.cattle.io/v1) is created, various CAPI objects are generated: RKECluster, RKEControlPlane, Cluster, RKEBootstrapTemplate, MachineDeployment and infra specific kinds like Amazonec2MachineTemplate.

Currently it is not easily possible to use other Cluster API providers with Rancher.

Cluster template can be used to automate cluster creation in a GitOps way (see [Kubernetes Master Class: Creating RKE2 Cluster Templates](https://youtu.be/xXtOP7CHbSA)).
