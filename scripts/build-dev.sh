# build dev base
docker build . -f php-fpm/build/Dockerfile --build-arg BASE_IMAGE_PHP="php:8.2.7-fpm-buster" --target dev-base --tag ghcr.io/cbrooney/base-php-fpm-dev:latest
docker push ghcr.io/cbrooney/base-php-fpm-dev:latest
