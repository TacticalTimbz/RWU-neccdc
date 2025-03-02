#!/bin/sh

source /etc/os-release
if [ "$ID" = "fedora" ]; then
    echo "yeet"
elif [ "$ID" = "ubuntu" ]; then
    echo "yeet"
elif [ "$ID" = "rocky" ]; then
    sudo dnf install -y nfs-utils
else
  echo "unable to install NFS"
fi

rm /etc/exports
cp ./exports /etc