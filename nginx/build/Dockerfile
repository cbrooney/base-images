ARG BASE_IMAGE_NGINX
FROM ${BASE_IMAGE_NGINX} as nginx-base

USER root

#COPY --chown=nginx:nginx ./public /var/www/html/public
COPY --chown=nginx:nginx nginx/build/bruni-home.conf /etc/nginx/conf.d/site.conf

EXPOSE 8000

USER root
