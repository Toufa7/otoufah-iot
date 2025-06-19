#!/bin/bash
# set -e
# curl -sfL https://get.k3s.io | sh -
# mkdir -p /home/vagrant/.kube
# sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
# sudo chown vagrant:vagrant /home/vagrant/.kube/config

echo "K3s server provision setup start"
echo "Installing K3s in server mode..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110" sh -

sudo systemctl enable k3s
sudo systemctl start k3s
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

#Sharing Node tokenin shared folder
sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/node-token
sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/kubeconfig
sudo sed -i 's/127.0.0.1/192.168.56.110/g' /vagrant/kubeconfig
sudo chmod 644 /vagrant/kubeconfig

#Sharing kube config in shared folder
mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown vagrant:vagrant /home/vagrant/.kube/config

echo "source <(kubectl completion bash)" >> ~/.bashrc
echo "K3s server provision setup complete"