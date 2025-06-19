#!/bin/bash

## Init

# Install Docker
echo -e "\033[34m$(date +%T) [INFO] Installing Docker\033[0m\033[0m"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Install K3D
echo -e "\033[34m$(date +%T) [INFO] Installing k3d\033[0m"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Creating cluster
echo -e "\033[34m$(date +%T) [INFO] Creating k3d cluster\033[0m"
k3d cluster create iot 

# Install Kubectl
echo -e "\033[34m$(date +%T) [INFO] Installing kubectl\033[0m"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install Argo CD CLI
echo -e "\033[34m$(date +%T) [INFO] Installing Argo CD\033[0m"
# curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
# rm argocd-linux-amd64

# Install Argo CD setup
echo -e "\033[34m$(date +%T) [INFO] Argo CD Setup\033[0m"
kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait deployment argocd-server -n argocd --for=condition=Available=True --timeout=30s
nohup kubectl port-forward svc/argocd-server -n argocd 8765:443 > /dev/null 2>&1 &

# Argo CD Credentials
echo -e "\033[34m$(date +%T) [INFO] Argo CD Credentials\033[0m"
kubectl get secrets argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo

# Login to Argo CD
echo -e "\033[34m$(date +%T) [INFO] Logging in to Argo CD\033[0m"
argocd login 127.0.0.1:8765 --insecure
argocd repo add https://gitlab.com/Toufa7/inception-of-things.git
argocd app create argocd-iota \
  --repo https://gitlab.com/Toufa7/inception-of-things.git\
  --path p2/confs \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace dev \
  --project default \
  --directory-recurse \
  --sync-policy automated

# Apply Kubernetes manifests
echo -e "\033[34m$(date +%T) [INFO] Applying Kubernetes manifests\033[0m"
kubectl apply -f ../confs/application.yaml

echo -e "\033[34m$(date +%T) [INFO] Setup complete\033[0m"

# k exec -n argocd -it argocd-server-99c485944-m48sz -- /bin/bash
# $ argocd repo add https://gitlab.com/Toufa7/inception-of-things.git --ssh-private-key-path  id_rsa
