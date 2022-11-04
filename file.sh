#!/bin/bash
set -x
USER=$1
Key_path=$2
IP=$(terraform output -json Instance_ips | jq -r '.[]')
echo $IP
touch Invnetory ~/tool-infra
echo "" > Invnetory
echo "[seed-nodes]" > Invnetory
for line in $IP
do
    y=$(echo "${line}") 
    IP=$(echo $y | awk -F, '{print $1}')
    echo "ansible_host=${IP} ansible_user=${USER} ansible_ssh_private_key_file=${Key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> Invnetory 
    ((i++))
done
cat Invnetory
