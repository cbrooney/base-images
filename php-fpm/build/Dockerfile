ARG BASE_IMAGE_PHP
FROM ${BASE_IMAGE_PHP} as prod-base

#LABEL org.opencontainers.image.source="https://github.com/cbrooney/bruni-home"

USER root

RUN apt-get update && \
    export XDEBUG_MODE=off && \
    docker-php-ext-install pdo pdo_mysql && \
    apt-get install -y librabbitmq-dev libssh-dev unzip libzip-dev libicu-dev libfcgi-bin && \
    echo "\n" | pecl install amqp && \
    echo "\n" | pecl install apcu && \
    docker-php-ext-enable amqp && \
    docker-php-ext-enable apcu && \
    docker-php-ext-install zip && \
    docker-php-ext-install intl && \
    docker-php-ext-enable intl && \
    docker-php-ext-install opcache && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer && \
    rm -f composer-setup.php && \
    apt-get -y remove apt-transport-https lsb-release software-properties-common && \
    apt-get -y autoremove && \
    chown www-data:www-data -R /var/www && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

COPY php-fpm/config/php-base.ini /usr/local/etc/php/conf.d/php-symfony.ini
# do not know if this is needed
# COPY config/zzz-docker.conf /usr/local/etc/php-fpm.d/zzz-docker.conf

#USER 10000
USER www-data


FROM prod-base as dev-base

# USER 0
USER root

RUN export XDEBUG_MODE=off && \
    echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' > /etc/apt/sources.list.d/symfony-cli.list && \
    apt-get update && \
    apt-get install -y nano vim less htop git autoconf build-essential wget openssh-client && \
#    apt-get install -y symfony-cli && \
#    pecl install xdebug && \
#    docker-php-ext-enable xdebug && \
    apt-get -y autoremove && \
    chown www-data:www-data -R /var/www && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

COPY php-fpm/config/php-dev.ini /usr/local/etc/php/conf.d/php-dev.ini
#COPY config/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# COPY script/toggle_xdebug.sh /usr/local/bin/toggle_xdebug
# COPY script/toggle_opcache.sh /usr/local/bin/toggle_opcache

USER www-data
