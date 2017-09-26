#!/usr/bin/env bash

if [ "$USER" == "root" ]; then
    echo 'Linking hostsnames to docker ips...'
    if [ ! -f /etc/hosts.dockback ]; then
        echo 'Backing up /etc/hosts' && cp /etc/hosts /etc/hosts.dockback
    fi

    echo 'Restoring /etc/hosts to original version' && cp /etc/hosts.dockback /etc/hosts

    for container in $( docker ps -q ); do
        echo -e "# Creating entry for container id ${container}" | tee -a /etc/hosts
        name=$( docker inspect $container | grep -E "Name\":\s\"\/.+\"" | tr -s " " | cut -d "/" -f 2 | cut -d "\"" -f 1 )
        ip=$( docker inspect $container | grep -E "IPAddress\":\s\".+\"" | tr -s " " | cut -d "\"" -f 4 )
        echo -e "${ip}\t${name}" | tee -a /etc/hosts
    done
else
    echo 'Imposible to link hostsnames to docker ips (reason: User => $USER instead of root)'
fi