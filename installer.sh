#!/bin/bash

if [ "$(whoami)" != "root" ]; then
        echo "Ejecutando como administrador..."
        exec sudo "$0" "$@"
fi

apt install nmap
apt install figlet
apt install git