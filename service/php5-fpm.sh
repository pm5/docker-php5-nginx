#!/bin/bash

POOL_FILE=/etc/php5/fpm/pool.d/www.conf

function updateEnv() {
  if [ -z "$2" ]; then
    echo "Environment variable '$1' not set."
    return
  fi

  if grep -q $1 ${POOL_FILE}; then
    NAME=$1
    VALUE=$(echo $2 | sed -e 's/\//\\\//g')
    sed -i "s/^env\[$1\].*/env[$1] = ${VALUE}/" ${POOL_FILE}
  else
    echo "env[$1] = $2" >> ${POOL_FILE}
  fi
}

for linkName in $(env | grep '_NAME=' | awk -F _NAME= '{print $1}'); do
  for envVar in $(env | grep "^${linkName}_" | awk -F = '{print $1}'); do
    updateEnv ${envVar} ${!envVar}
  done
done

mkdir -p /var/log
chmod 0755 /var/log
/usr/sbin/php5-fpm \
  && tail -f /var/log/php5-fpm.log  # fix strange "An another FPM instance" problem

