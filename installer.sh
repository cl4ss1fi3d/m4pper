#!/bin/bash

#if [ "$(whoami)" != "root" ]; then
 #       echo "Ejecutando como administrador..."
  #      exec sudo "$0" "$@"
#fi

apt install nmap
apt install figlet
apt install git

clear 
figlet m4pper install

mkdir /bin/m4pper/

curl -o /bin/m4pper/m4pper https://raw.githubusercontent.com/cl4ss1fi3d/m4pper/refs/heads/main/m4pper
curl -o /bin/m4pper/m4pper-src https://raw.githubusercontent.com/cl4ss1fi3d/m4pper/refs/heads/main/m4pper-src

echo 'PATH="$PATH:$HOME/bin/m4pper"' >> "$HOME/.bashrc"