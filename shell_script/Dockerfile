FROM ubuntu:latest

# Configure php
COPY ./phpinfo.php /var/www/phpinfo.php
COPY . /usr/src/php-app
WORKDIR /usr/src/php-app
RUN /usr/src/php-app/php_install.sh -e dev -v 8.0

# Configure NGINX


CMD php -r "phpinfo();"
