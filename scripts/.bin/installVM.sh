#!/bin/sh
# Pavel Hrdina 2024
#
# install vitalization components
sudo zypper --non-interactive install -t pattern kvm_server kvm_tools
# install VM GUI
sudo zypper --non-interactive install virt-manager
