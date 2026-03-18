#!/bin/bash

RED="\e[31m"
BLUE="\e[34m"
GREEN="\e[32m"
EC="\e[0m"

check_root() {
    if [ "$(whoami)" != "root" ]; then
        echo "Ejecutando como administrador..."
        exec sudo "$0" "$@"
    fi
}

check_root

check_install() {
    if dpkg -s $1 &>/dev/null; then
        echo ok
    else
        apt install "$1"
    fi
}

full_scan() {
    read -p "IP [Default: 192.168.1.0/24]: " ip
    read -p "Guardar en archivo? [Y/n]: " save
    if [[ "${save,,}" == "y" || "$save" == "" ]]; then
        echo ok
    fi

}

port_scan() {
    echo port scan
}

vuln_scan() {
    echo vuln scan
}

menu() {
    clear
    echo -e "${BLUE}"
    figlet "m4pper"
    echo -e "${EC}"
    echo ""

    # Mostrar mensaje de error si se pasa como argumento
    if [ -n "$1" ]; then
        echo -e "${RED}[!] Opción no válida.${EC}"
        echo ""
    fi

    echo -e "${GREEN}[1] Escanear toda la red."
    echo -e "[2] Escanear toda la red en búsqueda de puertos."
    echo -e "[3] Escanear vulnerabilidades en IP.${EC}"
    echo ""

    read -p "[#] Opción: " input

    case "$input" in
        1) full_scan;;
        2) port_scan;;
        3) vuln_scan;;
        *) menu "error";;  # pasamos "error" para mostrar el mensaje
    esac
}