#!/bin/bash

if [ ! -f /root/password.txt ]; then
  pwgen 16 1 > /root/password.txt
fi
echo root:$(cat /root/password.txt) | chpasswd

if [ $ENABLE_MY_KEY ]; then
  cp /tmp/mykey.pub /root/.ssh/authorized_keys
fi
