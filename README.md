# Inception Of Things

Iot a project that introduces me to K8S using K3S and K3D as well as CI/CD automated deployment with ArgoCD and basic infrastructure management (Infrastructure as code Iac) with Vagrant (defining VMs based on IP, RAM, etc, as well as sharing them)

# Concepts:

* K8S: container orchestration that automates deployment and scaling up (New Pods) and down (Removing Pods and rolling updates) & management of containerized apps, K8S perform high level orchestration tasks such as (Self healing ...) in collaboration with Docker runtime CRI performing low levels tasks in Pods such as (pulling, starting, stopping containers )




# Part 1: 

In this part, we simulate a 2-node k8s cluster using Vagrant first, act as a controller, and the second as a worker. They are connected through the shared node token.

# Part 2:

In this part, we show how K8S can host multiple web apps on one IP, using Ingress and different host headers, which later route requests to their appropriate apps by labels and selectors

# Part 3:

The last part was about centralizing and having a single source of truth for our deployment infrastructure using Git  or something called GitOps. For that, we used ArgoCD that continuously monitors my github repo, if I push a change, it automatically updates the K8S app without me touching the cluster directly  


### How ingress works: 

Exposing multiple services through a single point (loadbalancer), it creates a loadbalancer svc and listens on [80:443] regardless of exposed svc ports and uses host-based and path-based for routing rules, ingress relies on services that provide a single point to our end users
