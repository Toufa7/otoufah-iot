#!/bin/bash

# Install k3s
curl -sfL https://get.k3s.io | sh -

# Getting Cluster Token
# TOKEN=$(cat /var/lib/rancher/k3s/server/token)

# Getting Cluster IP
# kubectl get nodes -o wide