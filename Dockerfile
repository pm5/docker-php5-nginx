FROM phusion/baseimage:0.9.15
MAINTAINER Pomin Wu <pomin5@gmail.com>
ENV REFRESHED_AT 2015-03-16

ENV HOME /root
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -yq pwgen git-core && \
    apt-get install -yq vsftpd && \
    apt-get install -yq php5 php5-fpm php-apc php-pear php5-gd php5-curl php5-sqlite php5-mysql php5-pgsql && \
    apt-get install -yq nginx-full && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/service/root
ADD service/root.sh /etc/service/root/run
RUN chmod 755 /etc/service/root/run

RUN useradd -u 1000 -g www-data --home-dir /home/app -s /bin/bash -m app
RUN mkdir /etc/service/app
ADD service/app.sh /etc/service/app/run
RUN chmod 755 /etc/service/app/run

RUN rm -f /etc/service/sshd/down
ADD mykey.pub /tmp/mykey.pub

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
ADD etc/nginx/sites-enabled /etc/nginx/sites-enabled/
RUN mkdir /etc/service/nginx
ADD service/nginx.sh /etc/service/nginx/run
RUN chmod 755 /etc/service/nginx/run

RUN sed -i 's/memory_limit = 128M/memory_limit = 256M/' /etc/php5/fpm/php.ini
RUN mkdir /var/log/php5
RUN mkdir /etc/service/php5-fpm
ADD service/php5-fpm.sh /etc/service/php5-fpm/run
RUN chmod 755 /etc/service/php5-fpm/run

RUN echo "local_enable=YES" >> /etc/vsftpd.conf
RUN echo "write_enable=YES" >> /etc/vsftpd.conf
RUN echo "local_umask=022" >> /etc/vsftpd.conf
RUN echo "chroot_local_user=NO" >> /etc/vsftpd.conf
RUN echo "xferlog_file=/var/log/vsftpd/vsftpd.log" >> /etc/vsftpd.conf
RUN echo "anonymous_enable=NO" >> /etc/vsftpd.conf
RUN mkdir -p /var/log/vsftpd
RUN mkdir -p /var/run/vsftpd/empty
RUN mkdir /etc/service/vsftpd
ADD service/vsftpd.sh /etc/service/vsftpd/run
RUN chmod 755 /etc/service/vsftpd/run
