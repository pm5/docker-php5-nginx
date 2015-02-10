#!/bin/bash

mkdir -p /var/log
chmod 0755 /var/log
/usr/sbin/php5-fpm \
  && tail -f /var/log/php5-fpm.log  # fix strange "An another FPM instance" problem
