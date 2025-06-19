#!/bin/bash

# Install k3s
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
kubectl apply -f /home/vagrant/confs

# bash Auto completion for kubectl & vagrant
sudo apt install -y bash-completion
sudo apt install net-tools
echo "alias k='kubectl'" >> ~/.bashrc
echo "source <(kubectl completion bash)" >> ~/.bashrc
source ~/.bashrc

# Getting Cluster IP
kubectl get all -o wide