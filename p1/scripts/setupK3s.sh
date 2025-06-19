#!/bin/bash

echo "Installing K3s server..."

# Install K3s in server mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC=--flannel-iface eth1" sh -


# Enable and start K3s
sudo systemctl enable k3s
sudo systemctl start k3s

# Wait for K3s to be ready
echo "Waiting for K3s to be ready..."
sleep 30

# Check if K3s is running
sudo systemctl status k3s

sudo chmod 644 /etc/rancher/k3s/k3s.yaml

echo "K3s server installation complete"