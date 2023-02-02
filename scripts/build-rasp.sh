# only created locally, not pushed to github
docker build --platform linux/arm/v7 . -f php-fpm/build/Dockerfile --build-arg BASE_IMAGE_PHP="php:8.0.27-fpm-buster" --target prod-base --tag ghcr.io/cbrooney/base-php-fpm-rasp:latest
# docker push ghcr.io/cbrooney/base-php-fpm-rasp:latest
