#!/bin/bash

RED='\e[31m'
BLU='\e[34m'
GRN='\e[32m'
DEF='\e[0m'

echo -e "${BLU}Init script start ...${DEF}"

echo -e "${RED}[1/3] Removing old kubeconfig and node token${DEF}"
rm ./conf/kubeconfig ./conf/node-token

echo -e "${RED}[2/3] Destroying previous vms${DEF}"
vagrant destroy -f

echo -e "${RED}[3/3] Building new vms${DEF}"
vagrant up

echo -e "${GRN}Init script end${DEF}"