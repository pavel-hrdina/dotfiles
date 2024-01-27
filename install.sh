#!/usr/bin/env bash

# Script wide variables
NO_FORMAT="\033[0m"
F_BOLD="\033[1m"
C_OLIVE="\033[38;5;3m"
F_DIM="\033[2m"

echo -e "
----------------------------------------------------------
   ${F_BOLD}${C_OLIVE}
author          Pavel Hrdina     pavel.hrdina.ml@seznam.cz
license         GPL-3.0
   ${NO_FORMAT}
----------------------------------------------------------
"

#############################################
# YOU SHOULD ONLY NEED TO EDIT THIS SECTION #
#############################################

######################################
#Lines bellow should not be modified #
######################################

set -o pipefail
if [ "$EUID" -ne 0 ];then
    echo -e "${F_DIM}Please run as root${NO_FORMAT}\n"
    exit
fi

echo -e "${F_DIM}Check operating system...${NO_FORMAT}\n"

# Try using zypper to determine OS
if zypper -n --version; then
    echo -e "\n${F_DIM}Running openSUSE, continue...${NO_FORMAT}\n";
else
    echo -e "\n${F_DIM}Wrong distribution, modify the scrip, and then continue...${NO_FORMAT}\n" && exit
fi

echo "----------------------------------------------------------"

echo -e "${F_BOLD}STAGE ONE${NO_FORMAT}"
echo -e "${F_BOLD}Make system ready for installation...${NO_FORMAT}"

echo "----------------------------------------------------------"

# Test if OS is running as server
if [ "$(systemctl get-default)" == "graphical.target" ]; then
    echo -e "\n${F_DIM}Running openSUSE as desktop, continue...${NO_FORMAT}\n"
else
    echo -e "\n${F_DIM}Running as server, change systemctl setting to desktop...${NO_FORMAT}\n"
    systemctl isolate graphical.target
fi
