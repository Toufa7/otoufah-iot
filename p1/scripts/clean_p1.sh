#!/bin/bash

RED='\e[31m'
BLU='\e[34m'
GRN='\e[32m'
DEF='\e[0m'

echo -e "${BLU}Cleaning script start ...${DEF}"

echo -e "${RED}[1/3] Removing old kube config${DEF}"

rm ../conf/kubeconfig

echo -e "${RED}[2/3] Removing old node token${DEF}"

rm ../conf/node-token

echo -e "${RED}[3/3] Removing vms${DEF}"

vagrant destroy -f

echo -e "${GRN}Cleaning script end${DEF}"
