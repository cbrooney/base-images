#!/usr/bin/env bash

# Expects service to be called app in docker-compose.yml
DIR=$(pwd)
EXTENSION_FILE='/usr/local/etc/php/conf.d/docker-php-ext-opcache.ini'
DISABLED=$(grep -c ";zend_extension=opcache.so" $EXTENSION_FILE)
if [ "$DISABLED" == "0" ]; then
    CONTENT=$(cat $EXTENSION_FILE);
     echo "$CONTENT" | sed "s/zend_extension=opcache.so/;zend_extension=opcache.so/" > $EXTENSION_FILE
else
    CONTENT=$(cat $EXTENSION_FILE);
    echo "$CONTENT" | sed "s/;zend_extension=opcache.so/zend_extension=opcache.so/" > $EXTENSION_FILE
fi

kill -USR2 1
$(php -m | grep -q "Zend OPcache") && echo "Status: opcache ENABLED" || echo "Status: opcache DISABLED"