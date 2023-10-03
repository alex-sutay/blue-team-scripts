#!/bin/bash

# Must be run with sudo
# Boots non-specified users off of ssh
# Put this thing in crontab

EXCLUDED_USERS=("Freddy" "Mangle" "ansible" "grayteam" "root")

echo "== Booting SSH connections =="
ss -t -a | grep ssh | grep ESTAB |
while read line
do
        SRC_IP=`echo $line | cut -d ' ' -f 5 | cut -d ':' -f 1`
        PID=`who -u | grep $SRC_IP | xargs | cut -d ' ' -f 6`
        USER=`who -u | grep $SRC_IP | xargs | cut -d ' ' -f 1`
        if [[ ! $(echo ${EXCLUDED_USERS[@]} | fgrep -w $USER) ]]; then
                kill -HUP $PID
                echo "Killed $USER's SSH connection!"
        fi
done