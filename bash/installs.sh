#!/bin/bash
#run as sudo
apt-get update

#installs, add any installs to the variable
additions=("net-tools" "nmap" "sleuthkit" "tilde" "auditd")
apt-get -y install ${additions[@]}

systemctl enable auditd

#uninstalls, add any uninstalls to the variable
removals=("python2" "python3" "python3-pip")
apt-get remove ${removals[@]}