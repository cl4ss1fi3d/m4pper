#!/bin/bash

RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
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
    if [ -z "$ip" ]; then
        ip="192.168.1.0/24"
    elif [[ ! $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}(/([0-9]|[1-2][0-9]|3[0-2]))?$ ]]; then
        menu "error"
    fi

    read -p "Guardar en archivo? [Y/n]: " save
    if [[ "${save,,}" == "y" || -z "$save" ]]; then
        read -p "Nombre del archivo [Default: result]: " file
        if [ -z "$file" ]; then
            nmap -vv -sV -O $ip -oG result.gnmap
        else
            nmap -vv -sV -O $ip -oG "$file".gnmap
        fi
        echo -e "${GREEN}"
        read -p "[#] Leer archivo? [y/N]: " read
        if [[ -z "$read" || "${read,,}" == "n" ]]; then
            echo -e "[*] Puedes leerlo con 'cat "$file".gnmap'"
            echo -e "${EC}"
            sleep 3
            clear
            exit 0
        elif [[ "${read,,}" == "y" ]]; then
            clear
            cat "$file".gnmap
            exit 0
        else
            clear
            exit 0
        fi
    fi

    nmap -vv -sV -O $ip
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
    if [ "$1" == "error" ]; then
        echo -e "${RED}[!] Opción no válida.${EC}"
        echo ""
    fi

    echo -e "${GREEN}[1] Escanear toda la red."
    echo -e "[2] Escanear toda la red en búsqueda de puertos."
    echo -e "[3] Escanear vulnerabilidades en IP."
    echo -e "[Q] Cerrar el programa."
    echo -e "${CYAN}"

    read -p "[#] Opción: " {input,,}
    echo -e "${EC}"

    case "$input" in
        1) full_scan;;
        2) port_scan;;
        3) vuln_scan;;
        q) clear; exit 0;;
        *) menu "error";;  # pasamos "error" para mostrar el mensaje
    esac
}