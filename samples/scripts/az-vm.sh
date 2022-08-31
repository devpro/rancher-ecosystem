#!/bin/bash

# sets parameters
AZ_LOCATION=westeurope
RG_NAME=rg-bthomas-rke2220825
VM_NAME=vm-bthomas-rke2worker1
VM_IMAGE="Canonical:UbuntuServer:20.04-LTS:latest"
VM_SIZE=Standard_D2_v2
VM_ADMINUSER=azureuser
VNET_NAME=vnet-bthomas-rke220220825

# MANUAL: authenticates or double check account
az login
az account show

# OPTIONAL: creates a resource group
az group create --name ${RG_NAME} --location ${AZURE_LOCATION}

# OPTIONAL: creates a virtual network
az network vnet create \
  --resource-group ${RG_NAME} \
  --name ${VNET_NAME} \
  --address-prefix 10.0.0.0/16

# OPTIONAL: views an incomplete list of VM images
az vm image list

# creates a new virtual machine (see https://docs.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest#az-vm-create)
az vm create --resource-group ${RG_NAME} --name ${VM_NAME} \
  --image ${VM_IMAGE} --size ${VM_SIZE} \
  --vnet-name ${VNET_NAME} --subnet default \
  --storage-sku StandardSSD_LRS --data-disk-delete-option Delete \
  --public-ip-sku Standard --admin-username ${VM_ADMINUSER}

# MANUAL: copy the public IP (output as publicIpAddress)

# OPTIONAL: views the created VM
az vm show --name ${VM_NAME} --resource-group ${RG_NAME}

# updates the network interface
az vm update -n ${VM_NAME} -g ${RG_NAME} --set networkProfile.networkInterfaces[0].deleteOption=Delete

# OPTIONAL: enables auto-shutdown
az vm auto-shutdown -g ${RG_NAME} -n ${VM_NAME} --time 2030 --email "bertrand.thomas@suse.com"

# OPTIONAL: open ports
az vm open-port -g ${RG_NAME} -n ${VM_NAME} --name RKE2_ports --port 6443,9345 --priority 100

# OPTIONAL: connects to the VM
ssh ${VM_ADMINUSER}@${VM_PUBLICIPADDRESS}
