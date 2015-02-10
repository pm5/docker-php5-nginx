#!/bin/bash

if [ ! -f /home/app/password.txt ]; then
  mkdir -p /home/app
  chown -R app:www-data /home/app
  chmod 755 /home/app
  mkdir -p /var/www
  chown -R app:www-data /var/www
  chmod 755 /var/www
  ln -s /var/www /home/app/public
  pwgen 16 1 > /home/app/password.txt
fi
echo app:$(cat /home/app/password.txt) | chpasswd

if [ $ENABLE_MY_KEY ]; then
  mkdir -p /home/app/.ssh
  chown -R app:www-data /home/app/.ssh
  cp /tmp/mykey.pub /home/app/.ssh/authorized_keys
fi
