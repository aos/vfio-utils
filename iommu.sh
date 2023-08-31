#!/usr/bin/env bash
echo 'PCIe devices'
# shopt -s nullglob

for g in $(find /sys/kernel/iommu_groups/ -mindepth 1 -maxdepth 1 -type d | sort -V); do
    echo "IOMMU Group ${g##*/}:"
    for d in "$g/devices/"*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done
done

# Nvidia - IOMMU Group 26
# 2e:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU106 [GeForce RTX 2060 Rev. A] [10de:1f08] (rev a1)
# 2e:00.1 Audio device [0403]: NVIDIA Corporation TU106 High Definition Audio Controller [10de:10f9] (rev a1)
# 2e:00.2 USB controller [0c03]: NVIDIA Corporation TU106 USB 3.1 Host Controller [10de:1ada] (rev a1)
# 2e:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU106 USB Type-C UCSI Controller [10de:1adb]

# vfio-pci.ids=10de:1f08,10de:10f9

echo
echo 'USB Controllers'
for usb_ctrl in /sys/bus/pci/devices/*/usb*; do
    pci_path="${usb_ctrl%/*}"
    iommu_group="$(readlink $pci_path/iommu_group)"
    echo "Bus $(cat $usb_ctrl/busnum) --> ${pci_path##*/} (IOMMU group ${iommu_group##*/})"
    lsusb -s "${usb_ctrl#*/usb}:"
    echo
done

#   2033    sudo vi /etc/modprobe.d/vfio.conf
#   2035    sudo vi /etc/initramfs-tools/modules
#   2038    sudo update-initramfs -u
#   2039    lsinitramfs /boot/initrd.img | grep vfio
#   lspci -nnv
