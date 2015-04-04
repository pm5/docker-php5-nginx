FROM phusion/baseimage:0.9.15
MAINTAINER Pomin Wu <pomin5@gmail.com>
ENV REFRESHED_AT 2015-02-24

ENV HOME /root
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -yq pwgen git-core && \
    apt-get install -yq vsftpd && \
    apt-get install -yq php5 php5-fpm php-apc php-pear php5-gd php5-curl php5-sqlite php5-mysql php5-pgsql && \
    apt-get install -yq nginx-full && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/service/root \
    /etc/service/app \
    /etc/service/nginx \
    /etc/service/php5-fpm \
    /etc/service/vsftpd \
    /var/log/php5 \
    /var/log/vsftpd \
    /var/run/vsftpd/empty

ADD service/root.sh /etc/service/root/run

RUN useradd -u 1000 -g www-data --home-dir /home/app -s /bin/bash -m app
ADD service/app.sh /etc/service/app/run

RUN rm -f /etc/service/sshd/down
ADD mykey.pub /tmp/mykey.pub

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD etc/nginx/sites-enabled /etc/nginx/sites-enabled/
ADD service/nginx.sh /etc/service/nginx/run

ADD etc/php5/fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD etc/php5/fpm/php.ini /etc/php5/fpm/php.ini
ADD etc/php5/fpm/pool.d /etc/php5/fpm/pool.d
ADD service/php5-fpm.sh /etc/service/php5-fpm/run

RUN echo "local_enable=YES" >> /etc/vsftpd.conf
RUN echo "write_enable=YES" >> /etc/vsftpd.conf
RUN echo "local_umask=022" >> /etc/vsftpd.conf
RUN echo "chroot_local_user=NO" >> /etc/vsftpd.conf
RUN echo "xferlog_file=/var/log/vsftpd/vsftpd.log" >> /etc/vsftpd.conf
RUN echo "anonymous_enable=NO" >> /etc/vsftpd.conf
ADD service/vsftpd.sh /etc/service/vsftpd/run

RUN chmod 755 /etc/service/*/run
