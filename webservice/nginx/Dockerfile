FROM nginx:1.21.1 as build
RUN apt update -y && apt install iptables -y

#RUN iptables -I DOCKER-USER -i ext_if ! -s 10.0.0.0/24 -j DROP &&\
#    iptables -I DOCKER-USER

COPY ./templates/default.conf /etc/nginx/conf.d/default.conf

RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d && \
    chown -R nginx:nginx /var/cache/nginx/

FROM nginx:1.21.1-alpine
copy --from=build / /
USER nginx
CMD ["nginx", "-g", "daemon off;"]

