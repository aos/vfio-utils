#!/bin/sh
# should go under (qemu is filename) "/etc/libvirt/hooks/qemu"

command=$2

if [ "$command" = "started" ]; then
  systemctl set-property --runtime -- system.slice AllowedCPUs=0,1,4,5
  systemctl set-property --runtime -- user.slice AllowedCPUs=0,1,4,5
  systemctl set-property --runtime -- init.slice AllowedCPUs=0,1,4,5
elif [ "$command" = "release" ]; then
  systemctl set-property --runtime -- system.slice AllowedCPUs=0-7
  systemctl set-property --runtime -- user.slice AllowedCPUs=0-7
  systemctl set-property --runtime -- init.slice AllowedCPUs=0-7
fi
