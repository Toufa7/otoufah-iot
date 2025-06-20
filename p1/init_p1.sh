#!/bin/bash

RED='\e[31m'
BLU='\e[34m'
GRN='\e[32m'
DEF='\e[0m'

echo -e "${BLU}Init script start ...${DEF}"

echo -e "${RED}[1/4] Creating confs folder${DEF}"
mkdir confs

echo -e "${RED}[2/4] Removing old kubeconfig and node token${DEF}"
rm ./confs/kubeconfig ./confs/node-token

echo -e "${RED}[3/4] Destroying previous vms${DEF}"
vagrant destroy -f

echo -e "${RED}[4/4] Building new vms${DEF}"
vagrant up

echo -e "${GRN}Init script end${DEF}"