# Authentication

## Providers

### Azure AD

### Keycloak

* [Get started with Keycloak on Kubernetes started](https://www.keycloak.org/getting-started/getting-started-kube)
  * Open the Keycloak admin console
  * Create a Realm

  > A realm in Keycloak is the equivalent of a tenant. It allows creating isolated groups of applications and users. By default there is a single realm in Keycloak called master. This is dedicated to manage Keycloak and should not be used for your own applications.

  * Create a User and set Credentials
  * Login Account Console with the newly created User ("https://mydomain/realms/demo/account/#/")

* [Configure Keycloak (OIDC)](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-keycloak-oidc)

  * Create a Client
  * In Client details > Settings, enable Client authentication and save
  * In Client details > Client scopes, click on rancher-dedicated
    * Add mappers "By Configuration"
  * In Client details > Credentials, copy client secret
