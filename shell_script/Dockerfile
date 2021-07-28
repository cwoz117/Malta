FROM ubuntu:latest
WORKDIR /php-app

# PHP
COPY index.php /var/www/html/index.php
COPY php_install.sh .
COPY entrypoint.sh .
RUN ./php_install.sh -e dev -v 8.0
RUN sed -i 's/listen = \/run\/php\/php8\.0-fpm\.sock/listen = 9000/' /etc/php/8.0/fpm/pool.d/www.conf
RUN mkdir -p /var/run/php/
# Nginx
RUN DEBIAN_FRONTEND="noninteractive" apt install nginx -y
COPY default.conf /etc/nginx/sites-available/default

EXPOSE 80

#RUN useradd --create-home --shell /bin/bash php-app
#RUN chown -R php-app:php-app /php-app && \
#    chown -R php-app:php-app /var/run/php/ && \
#    chown -R php-app:php-app /etc/php/8.0
#    chown -R php-app:php-app /var/log/nginx && \
#    chown -R php-app:php-app /etc/nginx/conf.d && \
#USER php-app

CMD ["./entrypoint.sh"]
