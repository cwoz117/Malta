FROM ubuntu:latest

# Configure php
COPY ./index.php /var/www/html/index.php
COPY ./php_install.sh /php-app/php_install.sh
COPY ./entrypoint.sh /php-app/entrypoint.sh
RUN /php-app/php_install.sh -e dev -v 8.0
RUN sed -i 's/listen = \/run\/php\/php8\.0-fpm\.sock/listen = 9000/' /etc/php/8.0/fpm/pool.d/www.conf
RUN mkdir -p /var/run/php/

RUN DEBIAN_FRONTEND="noninteractive" apt install nginx -y
COPY ./default.conf /etc/nginx/sites-available/default

EXPOSE 80
CMD ["php-app/entrypoint.sh"]
#CMD "php-fpm8.0"
#CMD ["nginx",  "-g",  "daemon off;"]
