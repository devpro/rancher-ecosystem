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
# OPTIONAL: checks Kubernetes locally
sudo cp /etc/rancher/rke2/rke2.yaml .
chown bthomas:bthomas rke2.yaml
/var/lib/rancher/rke2/bin/kubectl get nodes --kubeconfig rke2.yaml
# retrieves the node token
sudo cat /var/lib/rancher/rke2/server/node-token
# OPTIONAL: cleanup
/usr/local/bin/rke2/rke2-killall.sh
/usr/local/bin/rke2/rke2-uninstall.sh

# installs RKE2 on the worker node
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sudo sh -
# enables the rke2-agent service
systemctl enable rke2-agent.service
# configures the rke2-agent service
sudo mkdir -p /etc/rancher/rke2/
sudo cat << \EOF | sudo tee /etc/rancher/rke2/config.yaml
server: https://<server>:9345
token: <token from server node>
EOF
# starts the service
sudo systemctl start rke2-agent.service
# OPTIONAL: follows the logs
sudo journalctl -u rke2-agent -f

# the cluster is now operational and can be accessed from a remote site (just edit the local ~/.kube/config file)
kubectl get nodes

# for self-signed certificates add insecure flag or edit kube/config file to comment certificate-authority-data line and add "insecure-skip-tls-verify: true" line under clusters/cluster
kubectl --insecure-skip-tls-verify get nodes
