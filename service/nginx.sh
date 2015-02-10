#!/bin/bash

mkdir -p /var/log/nginx
chmod 0755 /var/log/nginx
exec /usr/sbin/nginx
