#!/bin/bash

# Pavel Hrdina

win11user="USER"
win11pass="PASS"
win11ip="192.168.122.44"
win11name="windows11"

if [ -f ~/private/win11-credentials.sh ]; then
	echo "Credential file exists. Using the file."
	source "$HOME/private/win11-credentials.sh"
else
	echo "## Preparing to remotely access your Windows virtual machine ##"

	echo -n "Please enter your virtual machine name [default: $win11name]: "
	read -r vmname
	vmname=${vmname:-$win11name}

	echo -n "Please enter your virtual machine ip [default: $win11ip]: "
	read -r vmip
	vmip=${vmip:-$win11ip}

	echo -n "Please enter your username [default: $win11user]: "
	read -r user
	user=${user:-$win11user}

	echo -n "Please enter your password [default: $win11pass]: "
	read -r password
	password=${password:-$win11pass}
fi

# echo "Hello, $vmname, $vmip, $user, $password"

tmp=$(virsh --connect qemu:///system list | grep " $vmname " | awk '{ print $3}')

if [ "$tmp" == "x" ] || [ "$tmp" != "xrunning" ]; then
	echo "Virtual Machine $vmname is starting now... Waiting 30s before starting xfreerdp."
	notify-send "Virtual Machine $vmname 11 is starting now..." "Waiting 30s before starting xfreerdp."
	virsh --connect qemu:///system start $vmname
	sleep 30
else
	notify-send "Virtual Machine $vmname is already running." "Launching xfreerdp now!"
	echo "Starting xfreerdp now..."
fi

if command -v xfreerdp >/dev/null 2>&1; then
	xfreerdp -grab-keyboard /v:$vmip /size:100% /cert-ignore /u:$user /p:$password /d: /dynamic-resolution /gfx-h264:avc444 +gfx-progressive /f &
elif command -v xfreerdp3 >/dev/null 2>&1; then
	xfreerdp3 -v:$vmip -u:$user -p:$password -d: -dynamic-resolution /cert:ignore /f /gfx:AVC444 &
else
	echo "'xfreerdp' or 'xfreerdp3' command not found."
fi
