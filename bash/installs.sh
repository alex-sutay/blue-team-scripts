#!/bin/bash
#run as sudo
apt-get update

#installs, add any installs to the variable
additions=("net-tools" "nmap" "sleuthkit" "tilde" "auditd")
apt-get -y install ${additions[@]}

systemctl enable auditd

#uninstalls, add any uninstalls to the variable
#removals=("python2" "python3" "python3-pip")
#apt-get remove ${removals[@]}

#NOTE(from nate): So I did some testing on openstack and uninstalling python3 uninstalls ufw (and xorg so if we rebooted there'd be no x11 server)
#so we cant really do that :/
#proof of testing: https://pomf2.lain.la/f/z4dtre8.png & https://pomf2.lain.la/f/2g7awij6.png