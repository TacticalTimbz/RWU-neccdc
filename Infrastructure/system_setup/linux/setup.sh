#!/bin/sh
source /etc/os-release
if [ $ID="fedora" ]; then
  
elif [ $ID="ubuntu"]; then
  
else
  echo "unable to install packages"
fi