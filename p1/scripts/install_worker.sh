#!/bin/bash

RED='\e[31m'
BLU='\e[34m'
GRN='\e[32m'
DEF='\e[0m'

echo -e "${BLU}K3s agent provision setup start${DEF}"

echo -e "${GRN}Installing K3s in agent mode...${DEF}"

curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$(cat /vagrant/conf/node-token) INSTALL_K3S_EXEC="--node-ip=192.168.56.111 --flannel-iface eth1" sh -

mkdir -p /home/vagrant/.kube

cp /vagrant/conf/kubeconfig /home/vagrant/.kube/config

chown vagrant:vagrant /home/vagrant/.kube/config

echo "source <(kubectl completion bash)" >> ~/.bashrc

echo -e "${BLU}K3s agent setup complete${DEF}"