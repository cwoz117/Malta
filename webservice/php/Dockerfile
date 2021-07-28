FROM php:7.4-fpm as build
RUN pecl install redis-5.1.1
COPY ./templates/ /php-app/
RUN sed -i 's/;pm\.status_path = \/status/pm\.status_path = \/status/' \
    /usr/local/etc/php-fpm.d/www.conf
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN sed -i -e '$aextension=redis' /usr/local/etc/php/php.ini

FROM php:7.4-fpm-alpine3.13
COPY --from=build / /
EXPOSE 9000
USER www-data
CMD "php-fpm"
