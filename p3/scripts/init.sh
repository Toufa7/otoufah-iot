# https://argo-cd.readthedocs.io/en/stable/getting_started/

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Login through the UI admin:[$k get secrets argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | based64 -d]

k exec -n argocd -it argocd-server-99c485944-m48sz -- /bin/bash
    $ argocd login localhost:443 --insecure
    $ rgocd repo add git@gitlab.com:Toufa7/inception-of-things.git --ssh-private-key-path  id_rsa


# Installing argocd on host

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# CLI It's not fully functionall

argocd app create argocd-iot \
  --repo git@gitlab.com:Toufa7/inception-of-things.git\
  --path p2/ \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default \
  --project default \
  --directory-recurse \
  --sync-policy automated \