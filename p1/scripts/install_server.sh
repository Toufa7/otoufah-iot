#!/bin/bash

RED='\e[31m'
BLU='\e[34m'
GRN='\e[32m'
DEF='\e[0m'

echo -e "${BLU}K3s server provision setup start${DEF}"

echo -e "${GRN}Installing K3s in server mode...${DEF}"

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface eth1" sh -

sudo systemctl enable k3s

sudo systemctl start k3s

sleep 10

sudo chmod 644 /etc/rancher/k3s/k3s.yaml

#Sharing Node token in shared folder
sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/confs/node-token

sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/confs/kubeconfig

sudo sed -i 's/127.0.0.1/192.168.56.110/g' /vagrant/confs/kubeconfig

sudo chmod 644 /vagrant/confs/kubeconfig

#Sharing kube config in shared folder
mkdir -p /home/vagrant/.kube

sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config

sudo chown vagrant:vagrant /home/vagrant/.kube/config

echo "source <(kubectl completion bash)" >> ~/.bashrc

echo -e "${BLU}K3s server provision setup complete ${DEF}"