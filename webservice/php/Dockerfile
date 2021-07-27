FROM php:7.4-fpm
RUN pecl install redis-5.1.1
RUN apt-get update && apt-get install iputils-ping -y
COPY templates/ /php-app/

RUN sed -i 's/;pm\.status_path = \/status/pm\.status_path = \/status/' \
    /usr/local/etc/php-fpm.d/www.conf
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
EXPOSE 9000
CMD "php-fpm"
