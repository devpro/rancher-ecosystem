#!/bin/bash

# sets parameters
RESOURCE_PREFIX=bthomas-rancher1
KUBERNETES_VERSION=v1.23.8
NODE_COUNT=3
VM_SIZE=Standard_D2_v2
NGINX_INGRESS_VERSION=4.2.1
CERT_MANAGER_VERSION=v1.9.1
RANCHER_VERSION=2.6.7
RANCHER_HOSTNAME=rancher.demo
RANCHER_BOOTSTRAP_ADMIN=R@ncherR0ck$
AZURE_LOCATION=westeurope

# MANUAL: authenticates
az login

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

# installs NGINX Ingress Controller with Helm
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.service.type=LoadBalancer \
  --version ${NGINX_INGRESS_VERSION} \
  --create-namespace
# MANUAL: wait until External IP is set
kubectl get service ingress-nginx-controller --namespace=ingress-nginx
# MANUAL: edit your local host file with a line "EXTERNAL_IP RANCHER_HOSTNAME"

# installs cert-manager (https://cert-manager.io/) with Helm (https://cert-manager.io/docs/installation/helm/)
helm repo add jetstack https://charts.jetstack.io
helm repo update
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/${CERT_MANAGER_VERSION}/cert-manager.crds.yaml
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version ${CERT_MANAGER_VERSION}
# going forward: https://cert-manager.io/docs/configuration/, https://cert-manager.io/docs/usage/ingress/
# MANUAL: make sure all 3 pods are running fine (cert-manager, cert-manager-cainjector, cert-manager-webhook)
kubectl get pods --namespace cert-manager

# installs Rancher with Helm with Rancher-generated certificate
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update
kubectl create namespace cattle-system
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=${RANCHER_HOSTNAME} \
  --set bootstrapPassword=${RANCHER_BOOTSTRAP_ADMIN} \
  --version ${RANCHER_VERSION} \
  --set ingress.ingressClassName=nginx # new to 2.6.7
# MANUAL: waits for the deployment to complete
kubectl -n cattle-system rollout status deploy/rancher
# OPTIONAL: retrieves the admin password
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{ "\n" }}'
# OPTIONAL: makes sure Rancher ingress has a public IP
kubectl get ingress -A
# MANUAL: if no ingress class name / public IP, edit the rancher ingress object to add "ingressClassName: nginx" under "spec"
# makes sure Rancher UI is available
curl https://rancher.demo
# OPTIONAL: lists installed Helm charts
helm list -A
# OPTIONAL: remove Rancher
helm uninstall rancher --namespace cattle-system

# cleans up
az group delete --name rg-${RESOURCE_PREFIX} --yes --no-wait
