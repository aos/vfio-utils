#!/usr/bin/env bash

SHM_LG_PATH='/dev/shm/looking-glass'
VM_NAME='win10_gaming'

function check_start_vm {
  if virsh domstate $VM_NAME | rg -w 'shut' &>/dev/null; then
    echo 'Starting VM...'
    # sudo rm "$SHM_LG_PATH"
    virsh start "$VM_NAME"
  fi
}

function fix_shm_path {
  if [ ! -O "$SHM_LG_PATH" ]; then
    echo "taking ownership of path..."
    sudo chown $USER /dev/shm/looking-glass
  fi

  if [ ! -w "$SHM_LG_PATH" ]; then
    echo "fixing $SHM_LG_PATH permissions..."
    sudo chmod 660 /dev/shm/looking-glass
  fi
}

function start_lg {
  echo 'Starting Looking Glass...'
  ./looking_glass/client/build/looking-glass-client -m KEY_RIGHTCTRL
}

check_start_vm
# fix_shm_path
start_lg
