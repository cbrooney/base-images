# build prod base
docker build . -f php-fpm/build/Dockerfile --build-arg BASE_IMAGE_PHP="php:7.4.30-fpm-buster" --target prod-base --tag ghcr.io/cbrooney/base-php-fpm-prod:latest
docker push ghcr.io/cbrooney/base-php-fpm-prod:latest