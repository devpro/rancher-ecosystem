# Installation of Rancher

## Releases

Version                                                           | Date       | Links
------------------------------------------------------------------|------------|--------------------------------------------------------------------
[**2.7**](https://github.com/rancher/rancher/releases/tag/v2.7.0) | 2022-11-16 | [Forums](https://forums.rancher.com/t/rancher-release-v2-7-0/39478)

## General procedures

* [Install/Upgrade Rancher on a Kubernetes Cluster](https://docs.ranchermanager.rancher.io/pages-for-subheaders/install-upgrade-on-a-kubernetes-cluster)

## Providers

* [AKS](providers/microsoft-azure.md#install-rancher-on-aks)
* [Outscale](providers/3ds-outscale.md#create-a-rke2-cluster-and-install-rancher-on-it)
* [Nutanix](providers/nutanix.md#rancher--rke-on-nutanix)
* [vSphere](providers/wmware-vsphere.md#install-rancher-in-vsphere)

## Known issues

* If `cert-manager` is used, make sure `cert-manager` CRDs are applied before installing it with Helm (see [Install CustomResourceDefinitions](https://cert-manager.io/docs/installation/helm/#3-install-customresourcedefinitions))

## Tutorials

* [pitch7900/Rancher-3-nodes-install](https://github.com/pitch7900/Rancher-3-nodes-install) (in French)
