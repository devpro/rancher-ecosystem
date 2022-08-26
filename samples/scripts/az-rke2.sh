#!/bin/bash

# checks if NetworkManager is enabled (if it is follow https://docs.rke2.io/known_issues/#networkmanager)
sudo systemctl status NetworkManager
# checks if networkd is enabled
sudo systemctl status systemd-networkd.service
# makes sure firewalld is disabled
sudo systemctl status firewalld
# makes sure AppArmor is loaded
sudo aa-status

# installs RKE2 on the server node
curl -sfL https://get.rke2.io | sudo sh -
# enables the rke2-server service
sudo systemctl enable rke2-server.service
# starts the service
sudo systemctl start rke2-server.service
# OPTIONAL: follows the logs
sudo journalctl -u rke2-server -f
# OPTIONAL: check Kubernetes locally
sudo cp /etc/rancher/rke2/rke2.yaml .
chown bthomas:bthomas rke2.yaml
/var/lib/rancher/rke2/bin/kubectl get nodes --kubeconfig rke2.yaml
