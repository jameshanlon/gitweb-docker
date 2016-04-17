FROM nginx
MAINTAINER James Hanlon

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y gitweb fcgiwrap

RUN ln -s /usr/share/gitweb /opt/www

RUN rm -v /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx
ADD gitweb.conf /etc/gitweb.conf

CMD spawn-fcgi -s /var/run/fcgiwrap.socket /usr/sbin/fcgiwrap && \
    nginx "-g" "daemon off;"
