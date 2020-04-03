FROM alpine:3.11
#install packages
RUN apt-get update && apt-get install -y \
  nginx \
  mysql-server \
  php-fpm \
  php-mysql \

# Configure nginx
COPY /nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY /default /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
RUN rm /etc/php7/conf.d/php.ini
COPY /php.ini /etc/php7/conf.d/php.ini


RUN mkdir -p /var/www/html

# Make the document root a volume
VOLUME /var/www/html

WORKDIR /var/www/html
RUN git clone https://github.com/linuxdevgon/webappPHP.git
RUN systemctl restart php7.0-fpm
RUN systemctl restart nginx

