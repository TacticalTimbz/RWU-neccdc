#!/bin/sh
source /etc/os-release
if [ $ID="fedora" ]; then
    dnf install -y rootsh
else
    echo false
fi
if [ -f "/etc/default/useradd" ]; then
  cp -f useradd /etc/default/useradd
else
  echo "could not find /etc/default/useradd"
fi