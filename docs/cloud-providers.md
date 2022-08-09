# Working with Cloud Providers

## Azure

### Azure Cloud credentials

* Follow the the official procedure on how to [Use the portal to create an Azure AD application and service principal that can access resources](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
  * In Azure Active Directory, register a new application
    * Save the informations: Tenant ID, client ID, client secret
  * In the subscription > IAM, assign a Contributor role to the application
    * Save the information: Subscription ID
* Create a new Azure Cloud Credential in Rancher

### Azure/Rancher Tips

* Default Linux Admin username is `azureuser`

### Azure/Rancher references

* [Rancher Azure Quick Start Guide](https://rancher.com/docs/rancher/v2.5/en/quick-start-guide/deployment/microsoft-azure-qs/)
