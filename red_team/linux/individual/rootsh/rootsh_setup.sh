#!/bin/sh
source /etc/os-release
if [ $ID="fedora" ]; then
  dnf install -y rootsh
elif [ $ID="ubuntu"]; then
  apt install -y rootsh
else
  echo "unable to install rootsh"
fi

if [ -f "/etc/default/useradd" ]; then
  cp -f useradd /etc/default/useradd
else
  echo "could not find /etc/default/useradd"
fi

if [ -f "/etc/shells" ]; then
  cp -f shells /etc/shells
else  
  echo "could not find /etc/shells