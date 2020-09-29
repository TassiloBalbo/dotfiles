#!/bin/bash

# debugging output
set -x

# stop display manager
systemctl stop display-manager

# unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind

# unbind EFI-Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# wait for everything to get done
sleep 3

# unload all nvidia drivers
modprobe -r nvidia_drm
modprobe -r nvidia_modeset
modprobe -r nvidia_uvm
modprobe -r nvidia

# unbind the GPU from display driver
virsh nodedev-detach pci_0000_07_00_0
virsh nodedev-detach pci_0000_07_00_1
virsh nodedev-detach pci_0000_07_00_2
virsh nodedev-detach pci_0000_07_00_3

# load VFIO kernel module
modprobe vfio-pci