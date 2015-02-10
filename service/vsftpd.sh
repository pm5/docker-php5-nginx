#!/bin/bash

if [ $ENABLE_FTP ]; then
  mkdir -p /var/log
  chmod 0755 /var/log
  exec /usr/sbin/vsftpd
fi
