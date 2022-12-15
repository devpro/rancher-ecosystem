#!/bin/bash

# sets parameters
AZURE_LOCATION=westeurope
CERT_MANAGER_VERSION=v1.10.0
KUBERNETES_VERSION=v1.23.12
NODE_COUNT=2
RESOURCE_PREFIX=bthomas-kubemgmt01
SUBSCRIPTION_ID=060bb4b4-4d16-4f98-9c5a-58f61c38ff55
VM_SIZE=Standard_D2s_v3

# MANUAL: authenticates and sets account
az login
az account set --subscription $SUBSCRIPTION_ID

# creates resource group
az group create --name rg-${RESOURCE_PREFIX} --location ${AZURE_LOCATION}

# create AKS resource (Kubernetes cluster managed by Azure)
az aks create \
  --resource-group rg-${RESOURCE_PREFIX} \
  --name aks-${RESOURCE_PREFIX} \
  --kubernetes-version ${KUBERNETES_VERSION} \
  --node-count ${NODE_COUNT} \
  --node-vm-size ${VM_SIZE}

# adds cluster credentials to local kubectl config
az aks get-credentials --resource-group rg-${RESOURCE_PREFIX} --name aks-${RESOURCE_PREFIX}
chmod 600 ~/.kube/config

# makes sure Helm repo chart has been added (https://github.com/devpro/helm-charts/blob/main/README.md)
helm repo add devpro https://devpro.github.io/helm-charts
helm repo update

# installs NGINX Ingress Controller
helm upgrade --install ingress-nginx devpro/ingress-nginx --namespace ingress-nginx --create-namespace
# MANUAL: waits until External IP is set
kubectl get service ingress-nginx-controller --namespace=ingress-nginx
# saves NGINX Ingress service public IP
NGINX_PUBLIC_IP=`kubectl get service -n ingress-nginx ingress-nginx-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}'`

# installs cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/${CERT_MANAGER_VERSION}/cert-manager.crds.yaml
helm upgrade --install cert-manager devpro/cert-manager --namespace cert-manager --create-namespace
# MANUAL: makes sure all 3 pods are running fine (cert-manager, cert-manager-cainjector, cert-manager-webhook)
kubectl get pods,clusterissuer --namespace cert-manager

# installs Let's Encrypt cluster issuers
helm upgrade --install letsencrypt devpro/letsencrypt \
  --set registration.emailAddress=mypersonal@email.address \
  --namespace cert-manager
# MANUAL: makes sure there are 3 cluster issuers (letsencrypt-prod, letsencrypt-staging, selfsigned-cluster-issuer)
kubectl get clusterissuer

# installs Rancher with Helm
kubectl create namespace cattle-system
helm upgrade --install rancher devpro/rancher \
  --set rancher.hostname=rancher.${NGINX_PUBLIC_IP}.sslip.io \
  --namespace cattle-system
# MANUAL: with Rancher < 2.6.7, edit the rancher ingress object to add "ingressClassName: nginx" under "spec"
# checks everything is ok
kubectl get svc,deploy,pod,ingress,pv,certificate -n cattle-system
# MANUAL: retrieves generated password
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{ .data.bootstrapPassword|base64decode}}{{ "\n" }}'
# makes sure Rancher UI is available
curl https://rancher.${NGINX_PUBLIC_IP}.sslip.io
# MANUAL: edits Public IP address Azure resource (Configuration) to set a DNS name label, for example rancher-demo(.westeurope.cloudapp.azure.com), update the server-url in Rancher > Global Settings
kubectl edit ingress rancher -n cattle-system
# apiVersion: networking.k8s.io/v1
# kind: Ingress
# metadata:
# spec:
#   ingressClassName: nginx
#   rules:
#   - host: rancher-demo.westeurope.cloudapp.azure.com
#     http:
#       paths:
#       - backend:
#           service:
#             name: rancher
#             port:
#               number: 80
#         pathType: ImplementationSpecific
#   tls:
#   - hosts:
#     - rancher-demo.westeurope.cloudapp.azure.com
#     secretName: tls-rancher-ingress
# MANUAL: opens https://rancher.${NGINX_PUBLIC_IP}.sslip.io

# MANUAL: adds GitRepo
# apiVersion: fleet.cattle.io/v1alpha1
# kind: GitRepo
# spec:
#   branch: release/demo
#   clientSecretName: gitrepo-auth-rrxgw
#   insecureSkipTLSVerify: false
#   paths:
#   - fleet/ingress-nginx
#   - fleet/cert-manager
#   - fleet/sealed-secrets
#   repo: https://github.com/devpro/kubernetes-demo-definitions
#   targets: []

# OPTIONAL: removes Rancher
helm uninstall rancher --namespace cattle-system

# cleans up
az group delete --name rg-${RESOURCE_PREFIX} --yes --no-wait
