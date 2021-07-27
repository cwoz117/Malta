FROM php:7.4-fpm
RUN pecl install redis-5.1.1
COPY templates/index.php /php-app/index.php

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
EXPOSE 9000
CMD "php-fpm"
