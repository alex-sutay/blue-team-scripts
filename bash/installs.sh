#!/bin/bash
sudo apt-get update

#installs
sudo apt-get -y install net-tools
sudo apt-get -y install nmap
sudo apt-get -y install sleuthkit
sudo apt-get -y install tilde
sudo apt-get -y install auditd
sudo systemctl enable auditd

#uninstalls
sudo apt remove python2
sudo apt remove python3
sudo apt-get remove python3-pip
