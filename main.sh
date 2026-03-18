#!/bin/bash
source src.sh
check_root "$@"

check_install "nmap"
check_install "figlet"
clear

menu
