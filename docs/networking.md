# Networking

## General ideas

* Any K8s compliant CNI can be leveraged with RKE/k3s: bring your own CNI!

## Documentation

* [Container Network Interface (CNI) Providers](https://rancher.com/docs/rancher/v2.6/en/faq/networking/cni-providers/)
* [Troubleshooting](https://rancher.com/docs/rancher/v2.6/en/troubleshooting/networking/)
* [Rancher Nodes Ports](https://rancher.com/docs/rancher/v2.6/en/installation/requirements/ports/)
* Knowledge base
  * [Will Rancher fix the issue and release a patch, if the problem is root-caused in one of the Rancher 2.x CNI plugin add-ons such as Weave, Cisco ACI, Cilium, and Calico?](https://www.suse.com/support/kb/doc/?id=000020468)

## Cisco ACI (Application Centric Infrastructure)

* [Cisco ACI for Data Center](https://www.cisco.com/c/en/us/solutions/data-center-virtualization/application-centric-infrastructure/index.html)
* [Cisco ACI and Rancher Integration](https://www.cisco.com/c/en/us/td/docs/dcn/aci/containers/cisco-aci-and-rancher-integration.html)
* [RKE Cluster Configuration Reference > Project Network Isolation](https://rancher.com/docs/rancher/v2.6/en/cluster-admin/editing-clusters/rke-config-reference/#project-network-isolation)
* [ACI Virtualization Compatibility Matrix](https://www.cisco.com/c/dam/en/us/td/docs/Website/datacenter/aci/virtualization/matrix/virtmatrix.html)

## VMware NSX-T

### NSX-T overview

* [VMware NSX Documentation](https://docs.vmware.com/en/VMware-NSX/index.html)
  * [Key Concepts](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.2/installation/GUID-A1BBC650-CCE3-4AC3-A774-92B195183492.html)
  * [NSX-T Architecture Technical Overview](https://nsx.techzone.vmware.com/resource/vmware-nsx-t-architecture-technical-overview)
  * [NSX-T Reference Design Guide](https://nsx.techzone.vmware.com/resource/nsx-t-reference-design-guide-3-0) ([PDF](https://communities.vmware.com/t5/VMware-NSX-Documents/VMware-NSX-T-Reference-Design/ta-p/2778093))
    * [NSX-T Architecture and Components](https://nsx.techzone.vmware.com/sites/default/files/imported-images/node_2501/NSX-T-Reference-Design-Guide-3-0/NSX-T-Reference-Design-Guide-3-0.007.png)
* [Understand NSX-T learning path](https://nsx.techzone.vmware.com/understand-nsx-t)
* [VMware NSX Training and Demos](https://www.youtube.com/playlist?list=PLdYldEmmLm2nBcfxkp-wzE4SCohw2ynD3)
* [NSX-T, Kubernetes and Microsegmentation](https://www.virtualthoughts.co.uk/2018/08/01/nsx-t-kubernetes-and-microsegmentation/) - August 1, 2018

### NSX Container Plug-in (NCP)

* [Overview of NSX Container Plug-in](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.2/ncp-kubernetes/GUID-52A92986-0FDF-43A5-A7BB-C037889F7559.html)
  * [Installation Overview](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.2/ncp-kubernetes/GUID-22D54FC5-4B06-4FE1-86A9-96A953FA15B9.html)
  * [Ingress](https://docs.vmware.com/en/VMware-NSX-T-Data-Center/3.2/ncp-kubernetes/GUID-E03D6EE5-9C6C-457F-AD81-25CF2056F4D8.html)
* [Solve Container Networking Challenges with NSX Container Plugin](https://blogs.vmware.com/networkvirtualization/2020/05/nsx-container-plugin.html/) - May 7, 2020
* [NSX-T NSX Container Plugin NCP Architecture - Support Kubernetes](https://www.youtube.com/watch?v=DPlr7K2eEow)
* [Kubernetes and NSX-T – Part 1 Deploying Container Hosts](https://vnuggets.com/2019/10/02/kubernetes-and-nsx-t-part1-deploying-container-hosts/) - October 2, 2019
* [Using the NSX-T CNI with RKE2](https://www.virtualthoughts.co.uk/2022/07/04/using-the-nsx-t-cni-with-rke2/) ([GitHub](https://github.com/David-VTUK/rke2-nsxt)) - July 4, 2022
  * [RKE2 and NSX-T with Terraform](https://github.com/David-VTUK/rke2-nsxt-terraform)
* [VMware NSX-T 2.5.x and Kubernetes (K8S) Guide](https://github.com/dumlutimuralp/k8s-with-nsx-t-2.5.x)

### Antrea

> Antrea is a Kubernetes-native project that implements the Container Network Interface (CNI) and Kubernetes NetworkPolicy thereby providing network connectivity and security for pod workloads. Antrea extends the benefit of programmable networks from Open vSwitch (OVS) to Kubernetes.

→ [antrea.io](https://antrea.io/), [GitHub](https://github.com/antrea-io/antrea)

* [Connect and Secure your Apps with Antrea and VMware NSX-T 3.2](https://blogs.vmware.com/networkvirtualization/2022/02/connect-and-secure-your-apps-with-antrea-and-vmware-nsx-t-3-2.html/) - February 16, 2022
