#!/bin/bash

ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa

cp /home/vagrant/.ssh/id_rsa.pub /vagrant/scripts/controller_id_rsa.pub

chmod 644 /vagrant/scripts/controller_id_rsa.pub

curl -sfL https://get.k3s.io | sh -