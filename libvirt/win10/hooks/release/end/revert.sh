#!/bin/bash

# debugging output
set -x

# unload VFIO-PCI Kernel Driver
modprobe -r vfio-pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

# re-bind GPU to Nvidia Driver
virsh nodedev-reattach pci_0000_07_00_0
virsh nodedev-reattach pci_0000_07_00_1
virsh nodedev-reattach pci_0000_07_00_2
virsh nodedev-reattach pci_0000_07_00_3

# rebind VT consoles
echo 1 > /sys/class/vtconsole/vtcon0/bind

nvidia-xconfig --query-gpu-info > /dev/null 2>&1

# bind EFI-Framebuffer
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

modprobe nvidia_drm
modprobe nvidia_modeset
modprobe nvidia_uvm
modprobe nvidia

# restart display manager
systemctl start display-manager