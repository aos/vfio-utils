## vfio-utils

(Still WIP)

This is a collection of scripts and documentation I used to get VFIO + Looking
Glass up and running.

The ultimate purpose of VFIO is to be able to enable PCI passthrough, which
allows us to passthrough a graphics card to a virtual machine. This results in
native or near-native graphics performance.

### Documentation used

1. [Linux Kernel VFIO docs](https://www.kernel.org/doc/html/latest/driver-api/vfio.html)
2. [Arch linux article](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF)
3. [On NixOS](https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/)
4. [Windows VM](https://quantum5.ca/2022/04/18/windows-vm-gpu-passthrough-part-0-introduction/)

### TL;DR

The most important points to getting VFIO working correctly are:
1. Enabling IOMMU (and making sure our hardware supports it)
2. Isolating the devices from the host machine
    - As of kernel `5.4.26`, vfio module is included in the kernel. You can
      check via (`grep -i vfio /boot/config`), so it's unnecessary to load it
    - Find your IOMMU device IDs via the included `iommu.sh` script and add
      those PCI IDs in the included `vfio.conf` file. Make sure to move that to
      the appropriate location
3. Configure the VM to attach the PCI devices
4. Make sure to also include the appropriate drivers for virtio and vfio if you're using a Windows VM
