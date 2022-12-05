# Authentication

## Documentation

* [Users and Groups](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/manage-users-and-groups)
* [Role-Based Access Control (RBAC)](https://docs.ranchermanager.rancher.io/pages-for-subheaders/manage-role-based-access-control-rbac)
* [Cluster and Project Roles](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/manage-role-based-access-control-rbac/cluster-and-project-roles)

## Providers

### Azure AD

### Keycloak

See [Get started with Keycloak on Kubernetes started](https://www.keycloak.org/getting-started/getting-started-kube)
and [Configure Keycloak (OIDC)](https://docs.ranchermanager.rancher.io/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/authentication-config/configure-keycloak-oidc)

* Open the Keycloak admin console
  * Create a Realm

  > A realm in Keycloak is the equivalent of a tenant. It allows creating isolated groups of applications and users. By default there is a single realm in Keycloak called master. This is dedicated to manage Keycloak and should not be used for your own applications.

  * Create a User and set Credentials (password)
    * (Optional) Validate login on Account Console with the newly created User ("https://mydomain/realms/demo/account/#/")

  * Create a Client
    * In **Client details > Settings**, enable Client authentication and save (so can be added)
    * In **Client details > Client scopes**, click on `rancher-dedicated`
      * Add mappers "By Configuration"
    * In **Client details > Credentials**, copy client secret

  * Realm Settings > General tab, click OpenID Endpoint Configuration and copy from the JSON output will display values for issuer and authorization_endpoint

  ```json
  {
    "issuer":"https://keycloak.mydomain/realms/demo",
    "authorization_endpoint":"https://keycloak.mydomain/realms/demo/protocol/openid-connect/auth"
    // ...
  }
  ```

* Open Rancher
  * Configure a Keycloak OIDC account form, change Endpoints to Specify (advanced) and override the Issuer and Auth Endpoint values
