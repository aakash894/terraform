#!/bin/bash
  sudo apt update -y
  sudo apt-add-repository ppa:ansible/ansible -y
  sudo apt install ansible -y
  git clone https://github.com/aakash894/cassandra.git
