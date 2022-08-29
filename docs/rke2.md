# RKE2 (Rancher Kubernetes Engine v2)

> RKE2, also known as RKE Government, is Rancher's next-generation Kubernetes distribution. It is a fully conformant Kubernetes distribution that focuses on security and compliance within the U.S. Federal Government sector.

→ [docs](https://docs.rke2.io/)

## Architecture

![Architecture Overview](https://docs.rke2.io/architecture/overview.png)

→ [docs/architecture](https://docs.rke2.io/architecture/architecture/)

## Installation

### Azure VM

* Review VM specifications (example)
  * Size: Standard_D2s_v3 (2 vcpus, 8 GiB memory)
  * Operating System: Linux (Ubuntu 20.04)
  * Location: West Europe

* Creation
  * From the web UI
  * With Azure CLI: [quick start](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli), [tutorial](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-manage-vm), [sample](../samples/scripts/az-vm.sh)
  * With an IaC tool, such as Azure Resource Manager or Terraform

* Connect with SSH: `ssh <username>@<ip_or_hostname>`

* Follow the [Quick Start](https://docs.rke2.io/install/quickstart/), see the [example script](../samples/scripts/az-rke2.sh)

### Helm chart installed

NAME                | NAMESPACE   | CHART                                        | APP VERSION
--------------------|-------------|----------------------------------------------|------------
rke2-canal          | kube-system | rke2-canal-v3.22.2-build2022050902           | v3.22.2
rke2-coredns        | kube-system | rke2-coredns-1.19.400                        | 1.9.3
rke2-ingress-nginx  | kube-system | rke2-ingress-nginx-4.1.004                   | 1.2.0
rke2-metrics-server | kube-system | rke2-metrics-server-2.11.100-build2021111904 | 0.5.0

### Processes running on a server node

```bash
# RKE2 server
/usr/local/bin/rke2 server

# containerd
containerd -c /var/lib/rancher/rke2/agent/etc/containerd/config.toml -a /run/k3s/containerd/containerd.sock --state /run/k3s/containerd --root /var/lib/rancher/rke2/agent/containerd

# kubelet
kubelet --volume-plugin-dir=/var/lib/kubelet/volumeplugins --file-check-frequency=5s --sync-frequency=30s --address=0.0.0.0 --alsologtostderr=false --anonymous-auth=false --authentication-token-webhook=true --authorization-mode=Webhook --cgroup-driver=cgroupfs --client-ca-file=/var/lib/rancher/rke2/agent/client-ca.crt --cloud-provider=external --cluster-dns=10.43.0.10 --cluster-domain=cluster.local --container-runtime=remote --container-runtime-endpoint=unix:///run/k3s/containerd/containerd.sock --containerd=/run/k3s/containerd/containerd.sock --eviction-hard=imagefs.available<5%,nodefs.available<5% --eviction-minimum-reclaim=imagefs.available=10%,nodefs.available=10% --fail-swap-on=false --healthz-bind-address=127.0.0.1 --hostname-override=vm-bthomas-rke2server --kubeconfig=/var/lib/rancher/rke2/agent/kubelet.kubeconfig --log-file=/var/lib/rancher/rke2/agent/logs/kubelet.log --log-file-max-size=50 --logtostderr=false --node-labels= --pod-manifest-path=/var/lib/rancher/rke2/agent/pod-manifests --read-only-port=0 --resolv-conf=/run/systemd/resolve/resolv.conf --serialize-image-pulls=false --stderrthreshold=FATAL --tls-cert-file=/var/lib/rancher/rke2/agent/serving-kubelet.crt --tls-private-key-file=/var/lib/rancher/rke2/agent/serving-kubelet.key

# containerd shim runC v2: 1 command per container
/var/lib/rancher/rke2/data/v1.23.9-rke2r1-eef53a0d1ec2/bin/containerd-shim-runc-v2 -namespace k8s.io -id <container_id> -address /run/k3s/containerd/containerd.sock

# kube-proxy
kube-proxy --cluster-cidr=10.42.0.0/16 --conntrack-max-per-core=0 --conntrack-tcp-timeout-close-wait=0s --conntrack-tcp-timeout-established=0s --healthz-bind-address=127.0.0.1 --hostname-override=vm-bthomas-rke2server --kubeconfig=/var/lib/rancher/rke2/agent/kubeproxy.kubeconfig --proxy-mode=iptables

# kube-scheduler
kube-scheduler --permit-port-sharing=true --authentication-kubeconfig=/var/lib/rancher/rke2/server/cred/scheduler.kubeconfig --authorization-kubeconfig=/var/lib/rancher/rke2/server/cred/scheduler.kubeconfig --bind-address=127.0.0.1 --kubeconfig=/var/lib/rancher/rke2/server/cred/scheduler.kubeconfig --profiling=false --secure-port=10259

# kube-apiserver
kube-apiserver --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --allow-privileged=true --anonymous-auth=false --api-audiences=https://kubernetes.default.svc.cluster.local,rke2 --authorization-mode=Node,RBAC --bind-address=0.0.0.0 --cert-dir=/var/lib/rancher/rke2/server/tls/temporary-certs --client-ca-file=/var/lib/rancher/rke2/server/tls/client-ca.crt --egress-selector-config-file=/var/lib/rancher/rke2/server/etc/egress-selector-config.yaml --enable-admission-plugins=NodeRestriction,PodSecurityPolicy --enable-aggregator-routing=true --encryption-provider-config=/var/lib/rancher/rke2/server/cred/encryption-config.json --etcd-cafile=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt --etcd-certfile=/var/lib/rancher/rke2/server/tls/etcd/client.crt --etcd-keyfile=/var/lib/rancher/rke2/server/tls/etcd/client.key --etcd-servers=https://127.0.0.1:2379 --feature-gates=JobTrackingWithFinalizers=true --insecure-port=0 --kubelet-certificate-authority=/var/lib/rancher/rke2/server/tls/server-ca.crt --kubelet-client-certificate=/var/lib/rancher/rke2/server/tls/client-kube-apiserver.crt --kubelet-client-key=/var/lib/rancher/rke2/server/tls/client-kube-apiserver.key --profiling=false --proxy-client-cert-file=/var/lib/rancher/rke2/server/tls/client-auth-proxy.crt --proxy-client-key-file=/var/lib/rancher/rke2/server/tls/client-auth-proxy.key --requestheader-allowed-names=system:auth-proxy --requestheader-client-ca-file=/var/lib/rancher/rke2/server/tls/request-header-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/var/lib/rancher/rke2/server/tls/service.key --service-account-signing-key-file=/var/lib/rancher/rke2/server/tls/service.key --service-cluster-ip-range=10.43.0.0/16 --service-node-port-range=30000-32767 --storage-backend=etcd3 --tls-cert-file=/var/lib/rancher/rke2/server/tls/serving-kube-apiserver.crt --tls-private-key-file=/var/lib/rancher/rke2/server/tls/serving-kube-apiserver.key

# etcd
etcd --config-file=/var/lib/rancher/rke2/server/db/etcd/config

# cloud-controller-manager
cloud-controller-manager --allocate-node-cidrs=true --authentication-kubeconfig=/var/lib/rancher/rke2/server/cred/cloud-controller.kubeconfig --authorization-kubeconfig=/var/lib/rancher/rke2/server/cred/cloud-controller.kubeconfig --bind-address=127.0.0.1 --cloud-provider=rke2 --cluster-cidr=10.42.0.0/16 --configure-cloud-routes=false --kubeconfig=/var/lib/rancher/rke2/server/cred/cloud-controller.kubeconfig --node-status-update-frequency=1m0s --port=0 --profiling=false

# kube-controller-manager
kube-controller-manager --flex-volume-plugin-dir=/var/lib/kubelet/volumeplugins --terminated-pod-gc-threshold=1000 --permit-port-sharing=true --allocate-node-cidrs=true --authentication-kubeconfig=/var/lib/rancher/rke2/server/cred/controller.kubeconfig --authorization-kubeconfig=/var/lib/rancher/rke2/server/cred/controller.kubeconfig --bind-address=127.0.0.1 --cluster-cidr=10.42.0.0/16 --cluster-signing-kube-apiserver-client-cert-file=/var/lib/rancher/rke2/server/tls/client-ca.crt --cluster-signing-kube-apiserver-client-key-file=/var/lib/rancher/rke2/server/tls/client-ca.key --cluster-signing-kubelet-client-cert-file=/var/lib/rancher/rke2/server/tls/client-ca.crt --cluster-signing-kubelet-client-key-file=/var/lib/rancher/rke2/server/tls/client-ca.key --cluster-signing-kubelet-serving-cert-file=/var/lib/rancher/rke2/server/tls/server-ca.crt --cluster-signing-kubelet-serving-key-file=/var/lib/rancher/rke2/server/tls/server-ca.key --cluster-signing-legacy-unknown-cert-file=/var/lib/rancher/rke2/server/tls/server-ca.crt --cluster-signing-legacy-unknown-key-file=/var/lib/rancher/rke2/server/tls/server-ca.key --configure-cloud-routes=false --controllers=*,-service,-route,-cloud-node-lifecycle --feature-gates=JobTrackingWithFinalizers=true --kubeconfig=/var/lib/rancher/rke2/server/cred/controller.kubeconfig --profiling=false --root-ca-file=/var/lib/rancher/rke2/server/tls/server-ca.crt --secure-port=10257 --service-account-private-key-file=/var/lib/rancher/rke2/server/tls/service.key --use-service-account-credentials=true

# cluster-proportional-autoscaler
/cluster-proportional-autoscaler --namespace=kube-system --configmap=rke2-coredns-rke2-coredns-autoscaler --target=Deployment/rke2-coredns-rke2-coredns --logtostderr=true --v=2

# NGINX Ingress Controller (initialized with https://github.com/Yelp/dumb-init)
/nginx-ingress-controller --election-id=ingress-controller-leader --controller-class=k8s.io/ingress-nginx --ingress-class=nginx --configmap=kube-system/rke2-ingress-nginx-controller --validating-webhook=:8443 --validating-webhook-certificate=/usr/local/certificates/cert --validating-webhook-key=/usr/local/certificates/key --watch-ingress-without-class=true
```

### Processes running on a worker node

```bash
# RKE2 agent
/usr/local/bin/rke2 agent

# containerd
containerd -c /var/lib/rancher/rke2/agent/etc/containerd/config.toml -a /run/k3s/containerd/containerd.sock --state /run/k3s/containerd --root /var/lib/rancher/rke2/agent/containerd

# kubelet
kubelet --volume-plugin-dir=/var/lib/kubelet/volumeplugins --file-check-frequency=5s --sync-frequency=30s --address=0.0.0.0 --alsologtostderr=false --anonymous-auth=false --authentication-token-webhook=true --authorization-mode=Webhook --cgroup-driver=systemd --client-ca-file=/var/lib/rancher/rke2/agent/client-ca.crt --cloud-provider=external --cluster-dns=10.43.0.10 --cluster-domain=cluster.local --container-runtime=remote --container-runtime-endpoint=unix:///run/k3s/containerd/containerd.sock --containerd=/run/k3s/containerd/containerd.sock --eviction-hard=imagefs.available<5%,nodefs.available<5% --eviction-minimum-reclaim=imagefs.available=10%,nodefs.available=10% --fail-swap-on=false --healthz-bind-address=127.0.0.1 --hostname-override=vm-bthomas-rke2worker1 --kubeconfig=/var/lib/rancher/rke2/agent/kubelet.kubeconfig --log-file=/var/lib/rancher/rke2/agent/logs/kubelet.log --log-file-max-size=50 --logtostderr=false --node-labels= --pod-manifest-path=/var/lib/rancher/rke2/agent/pod-manifests --read-only-port=0 --resolv-conf=/run/systemd/resolve/resolv.conf --serialize-image-pulls=false --stderrthreshold=FATAL --tls-cert-file=/var/lib/rancher/rke2/agent/serving-kubelet.crt --tls-private-key-file=/var/lib/rancher/rke2/agent/serving-kubelet.key

# containerd shim runC v2: 1 command per container
/var/lib/rancher/rke2/data/v1.23.9-rke2r1-eef53a0d1ec2/bin/containerd-shim-runc-v2 -namespace k8s.io -id <container_id> -address /run/k3s/containerd/containerd.sock

# kube-proxy
kube-proxy --cluster-cidr=10.42.0.0/16 --conntrack-max-per-core=0 --conntrack-tcp-timeout-close-wait=0s --conntrack-tcp-timeout-established=0s --healthz-bind-address=127.0.0.1 --hostname-override=vm-bthomas-rke2worker1 --kubeconfig=/var/lib/rancher/rke2/agent/kubeproxy.kubeconfig --proxy-mode=iptables

# NGINX Ingress Controller (initialized with https://github.com/Yelp/dumb-init)
/nginx-ingress-controller --election-id=ingress-controller-leader --controller-class=k8s.io/ingress-nginx --ingress-class=nginx --configmap=kube-system/rke2-ingress-nginx-controller --validating-webhook=:8443 --validating-webhook-certificate=/usr/local/certificates/cert --validating-webhook-key=/usr/local/certificates/key --watch-ingress-without-class=true
```
