#!/bin/bash

if [ ! -f /root/password.txt ]; then
  pwgen 16 1 > /root/password.txt
fi
echo root:$(cat /root/password.txt) | chpasswd
