# Microsoft Azure

## Getting started

### Ressources

Name                               | Type
-----------------------------------|------------------------------
**AKS** (Azure Kubernetes Service) | Kubernetes cluster management

### Best practices

* [Azure resource naming convention](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)

![Diagram of the components of an Azure resource name](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/_images/ready/resource-naming.png)

### Tips

* When creating an Azure VM from Azure, the default Linux Admin username is `azureuser`

## Usecases

### Install Rancher on AKS

* [Installing Rancher on AKS](https://docs.ranchermanager.rancher.io/getting-started/installation-and-upgrade/install-upgrade-on-a-kubernetes-cluster/rancher-on-aks)
    * `samples/scripts/aks-rancher-installation.sh`

### Provision AKS from Rancher

#### Cloud credentials

In order to authenticate and authorize actions against Azure, you need to create an Azure Active Directory (AD) application. It can be done through the web UI (portal) or the command line.

* [Use the portal](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal).
    * In `Azure Active Directory` > `App registrations`, register a new application and save the value of Tenant ID, client ID, client secret
    * In `Subscription` > `IAM`, assign a Contributor role to the application and save the Subscription ID value

Then, in Rancher add the newly created credentials.

* Create a new Azure Cloud Credential in Rancher

#### AKS Kubernetes cluster creation from Rancher

* In `Cluster Management`, click on `Create` (it will the provider selection page)
    * Under `Provision new nodes and create a cluster using RKE2/K3s` (make sure `RKE2/K3s` is checked), click on `Azure` (it will open the `Cluster: Create Azure` form)
        * Under `Machine Pools`,  click on `Show Advanced` and make sure to override all Azure ressource names
        * Under `Cluster Configuration` > `Basics`, select "Azure" in `Cloud Provider` list and fill `Cloud Provider Config` field (see [Setting up the Azure Cloud Provider](https://rancher.com/docs/rancher/v2.6/en/cluster-provisioning/rke-clusters/cloud-providers/azure/))

        ```json
        {   
          "cloud":"AzurePublicCloud",
          "tenantId": "<tenant_id>",
          "aadClientId": "<azuread_application_clientid>",
          "aadClientSecret": "<azuread_application_clientsecret>",
          "subscriptionId": "<azuread_application_clientid>",
          "resourceGroup": "<rg_name>",
          "location": "<azure_location>",
          "subnetName": "<subnet_name>",
          "securityGroupName": "<nsg_name>",
          "securityGroupResourceGroup": "<rg_name>",
          "vnetName": "<vnet_name>",
          "vnetResourceGroup": "<rg_name>",
          "primaryAvailabilitySetName": "<avs_name>",
          "routeTableResourceGroup": "<rg_name>",
          "cloudProviderBackoff": false,
          "useManagedIdentityExtension": false,
          "useInstanceMetadata": true
        }
        ```

        * Under `Cluster Configuration` > `Advanced` > `Additional Controller Manager Args`, click `Add` and add the flag `--configure-cloud-routes=false` (see [Rancher issue #34367](https://github.com/rancher/rancher/issues/34367))

### Use Azure VM as Kubernetes nodes

#### Ingress Controller in a Kubernetes cluster with Azure VM nodes

```bash
# installs with helm (see https://kubernetes.github.io/ingress-nginx/deploy/)
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

# checks NGINX Ingress Controller service (if EXTERNAL-IP gets stuck at <pending> then you need to look at the Cloud Provider configuration)
kubectl --namespace ingress-nginx get services -o wide ingress-nginx-controller
```

## Known issues

### AKS cluster on a service princical with a new secret

Once the secret used by the Cloud Credentials is revoked, we have to create another one and may prevent the AKS cluster from starting. In this case run the following command:

```bash
az aks update-credentials --resource-group rg-xxxx --name aks-xxxx --reset-service-principal --service-principal "xxxx" --client-secret "xxxx"
```

See [AKS startup error “Token refresh failed with invalid client secret error”](https://blog-bertrand-thomas.devpro.fr/2023/08/22/aks-startup-error-token-refresh-failed-with-invalid-client-secret-error/) for more information.
