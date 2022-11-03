#!/bin/bash
  sudo apt update -y
  sudo apt-add-repository ppa:ansible/ansible -y
  sudo apt install ansible -y
  ansible-galaxy collection install amazon.aws -y
  sudo apt-get install python3 -y
  sudo apt-get install python3-pip -y
  sudo pip3 install boto3 -y
  git clone https://github.com/aakash894/cassandra.git
