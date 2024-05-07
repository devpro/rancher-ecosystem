# Rancher Applications

Available in Rancher, in the menu for a Cluster, with the "Apps" link.

## Chart repositories

### Indexes

TODO: check & update with Rancher 2.8

```txt
https://charts.rancher.io/index.yaml
https://partner-charts.rancher.io/index.yaml
https://rke2-charts.rancher.io/index.yaml
https://rancher.github.io/elemental-operator/index.yaml
https://raw.githubusercontent.com/rancher/ui-plugin-charts/main/index.yaml
https://raw.githubusercontent.com/rancher/partner-extensions/gh-pages/index.yaml
```

### Official charts

* Helm chart codebase for Rancher 2.8: [rancher/charts](https://github.com/rancher/charts/tree/release-v2.8/charts)

* Helm chart repository for Rancher Prime: [charts.rancher.com/server-charts/prime](https://charts.rancher.com/server-charts/prime)

* Helm CLI

```bash
helm repo add rancher-charts https://charts.rancher.io
helm upgrade --install --namespace xxxx yyyy rancher-charts/yyyy --create-namespace
```

### Partner charts

* Repository for Partner charts: [rancher/partner-charts](https://github.com/rancher/partner-charts/tree/main-source/charts)
