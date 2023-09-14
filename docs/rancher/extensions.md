# Rancher extensions

💡 Introduced in Rancher 2.7.0

> Extensions allow users, developers, partners, and customers to extend and enhance the Rancher UI. In addition, users can make changes and create enhancements to their UI functionality independent of Rancher releases.
Extensions will enable users to build on top of Rancher to better tailor it to their respective environments.

→ [ranchermanager.docs.rancher.com](https://ranchermanager.docs.rancher.com/integrations-in-rancher/rancher-extensions), [rancher.github.io/dashboard](https://rancher.github.io/dashboard/extensions/home)

## Quick start

* Enable Extensions in Rancher
    * From the Rancher UI, from the left menu, under Configuration, click on "Extensions"
    * If "Extension support is not enabled" is displayed, then click on "Enable"
    * If no extensions is displayed in "Available" you may have to refresh the page
    * By default, two extensions will be available: "Elemental" and "Kubewarden"

## Available extensions

* [Rancher UI plugins](https://github.com/rancher/ui-plugin-charts)
    * [Elemental](https://github.com/rancher/elemental-ui) ([Helm chart](https://github.com/rancher/elemental-ui/tree/main/charts/elemental))
    * [Kubewarden](https://github.com/kubewarden/ui) ([Helm chart](https://github.com/kubewarden/ui/tree/main/charts/kubewarden))
* [Rancher Partner Extensions](https://github.com/rancher/partner-extensions) (installation simplified in Rancher UI, see [PR #9260](https://github.com/rancher/dashboard/pull/9260))

## Samples

* [Rancher UI Plugin examples](https://github.com/rancher/ui-plugin-examples)
* [Devpro samples](https://github.com/devpro/rancher-extensions-samples)

## Creating an extension

* [Getting Started](https://rancher.github.io/dashboard/extensions/extensions-getting-started)
* Node driver extension
    * [example](https://github.com/rancher/ui-plugin-examples/tree/main/pkg/node-driver)
    * [docs](https://rancher.github.io/dashboard/extensions/usecases/node-driver/machine-config)
