# Rancher Fleet

## About

> Fleet is a container management and deployment engine designed to offer users more control on the local cluster and constant monitoring through GitOps

→ [fleet.rancher.io](https://fleet.rancher.io/), [GitHub](https://github.com/rancher/fleet)

## Quick start

```bash
# downloads fleet object manifests
helm template fleet-crd https://github.com/rancher/fleet/releases/download/v0.3.9/fleet-crd-0.3.9.tgz > temp/fleet-crd.yaml
helm template fleet https://github.com/rancher/fleet/releases/download/v0.3.9/fleet-crd-0.3.9.tgz > temp/fleet.yaml

# applies the changes
kubectl apply --wait=true -f temp/fleet-crd.yaml -n cattle-fleet-system
kubectl apply --wait=true -f temp/fleet.yaml -n cattle-fleet-system
```
