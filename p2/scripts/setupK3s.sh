#!/bin/bash

# Install k3s
curl -sfL https://get.k3s.io | sh -

sudo chmod 644 /etc/rancher/k3s/k3s.yaml

alias k='kubectl'

kubectl apply -f deployment.yaml

# bash Auto completion for kubectl & vagrant
sudo apt-get install -y bash-completion
echo "source <(kubectl completion bash)" >> ~/.bashrc
source ~/.bashrc

# Getting Cluster Token
# TOKEN=$(cat /var/lib/rancher/k3s/server/token)

# Getting Cluster IP
# kubectl get nodes -o wide