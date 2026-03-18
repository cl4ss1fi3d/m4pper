#!/bin/bash

if [ "$(whoami)" == "root" ]; then
        echo "[!] Por favor, no ejecutes como root."
        exit 1
fi

sudo apt install nmap
sudo apt install git
sudo apt install figlet

clear 
figlet m4pper install

cd /bin

sudo curl -O https://raw.githubusercontent.com/cl4ss1fi3d/m4pper/refs/heads/main/m4pper
sudo chmod +x m4pper
sudo curl -O https://raw.githubusercontent.com/cl4ss1fi3d/m4pper/refs/heads/main/m4pper-src
cd - &> /dev/null