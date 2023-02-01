# build dev base
docker build . -f php-fpm/build/Dockerfile --build-arg BASE_IMAGE_PHP="php:8.0.27-fpm-buster" --target dev-base --tag ghcr.io/cbrooney/base-php-fpm-dev:8.0.27
docker push ghcr.io/cbrooney/base-php-fpm-dev:8.0.27
