# Working with Cloud Providers

## Azure

### Azure Cloud credentials

In order to authenticate and authorize actions against Azure, you need to create an Azure Active Directory (AD) application. It can be done through the web UI (portal) or the command line.

* [Use the portal](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal).
  * In `Azure Active Directory` > `App registrations`, register a new application and save the value of Tenant ID, client ID, client secret
  * In `Subscription` > `IAM`, assign a Contributor role to the application and save the Subscription ID value

Then, in Rancher add the newly created credentials.

* Create a new Azure Cloud Credential in Rancher

### Kubernetes cluster creation from Rancher

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

    * Under `Cluster Configuration` > `Advanced section`, click `Add` under `Additional Controller Manager Args` and add the flag `--configure-cloud-routes=false`

### Azure Tips

* When creating an Azure VM from Azure, the default Linux Admin username is `azureuser`

### Ingress Controller in a Kubernetes cluster with Azure VM nodes

```bash
# installs with helm (see https://kubernetes.github.io/ingress-nginx/deploy/)
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

# checks NGINX Ingress Controller service (if EXTERNAL-IP gets stuck at <pending> then you need to look at the Cloud Provider configuration)
kubectl --namespace ingress-nginx get services -o wide ingress-nginx-controller
```
