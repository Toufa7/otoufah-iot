#!/bin/bash
set -e

mkdir -p /home/vagrant/.ssh
cat /vagrant/scripts/controller_id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

K3S_URL="https://192.168.56.110:6443"
K3S_TOKEN=$(cat /vagrant/scripts/token.txt)
curl -sfL https://get.k3s.io | K3S_URL=$K3S_URL K3S_TOKEN=$K3S_TOKEN sh -