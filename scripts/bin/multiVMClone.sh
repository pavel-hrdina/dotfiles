#!/bin/bash

#############################################################
#    script          multiVMClone pavel.hrdina.ml@seznan.cz #
#    author          Pavel Hrdina
#############################################################

# This script creates a number of template clones using qm in
# proxmox. The script should work on any template you have set
# up. Happy cloning!

#############################################
# You should only need to edit this section #
#############################################

C_GREEN4="\033[38;5;28m"

# Set the template to clone machines from
templateID=5000

# Machines
vm1="master-k3s-ubuntu-001"
vm2="master-k3s-ubuntu-002"
vm3="master-k3s-ubuntu-003"
vm4="master-k3s-ubuntu-004"
vm5="master-k3s-ubuntu-005"
vm6="admin-k3s-ubuntu-006"

# An array with machine names
allVMs=("$vm1" "$vm2" "$vm3" "$vm4" "$vm5" "$vm6")

# Machine IDs
vm1ID=101
vm2ID=102
vm3ID=103
vm4ID=104
vm5ID=105
vm6ID=106

allVMsID=("$vm1ID" "$vm2ID" "$vm3ID" "$vm4ID" "$vm5ID" "$vm6ID")

# Machine MAC adresses that are reserved in dhcp, comment this line,
# , and lines x, if you don't want the MACs to be changed

vm1MAC="BC:24:11:17:D5:A1"
vm2MAC="BC:24:11:4A:0E:0C"
vm3MAC="BC:24:11:D2:1C:E0"
vm4MAC="BC:24:11:DE:20:A0"
vm5MAC="BC:24:11:19:05:2C"
vm6MAC="BC:24:11:49:CC:E0"

allVMsMACS=("$vm1MAC" "$vm2MAC" "$vm3MAC" "$vm4MAC" "$vm5MAC" "$vm6MAC")


######################################
#Lines bellow should not be modified #
######################################
set -o pipefail

echo -e "${C_GREEN4}\033[1mCloning virtual machines with names\033[0"
echo -e "\n"

# Clone the machines and set macs
for i in ${!allVMs[*]}; do
    echo -e "\033[1m\nCloning virtual machine $i\033[0m\n"
    qm clone "$templateID" "${allVMsID[$i]}" --full --name "${allVMs[$i]}"

    echo -e "\033[1m\nSetting virtual machine '${allVMs[$i]}' MAC adress \033[0m\n"
    qm set "${allVMsID[$i]}" -net0 bridge=vmbr0,virtio="${allVMsMACS[$i]}"
done

echo -e "${C_GREEN4}\033[1m\nDONE!\033[0n"
