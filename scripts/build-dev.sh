# build dev env
docker build . -f php-fpm/build/Dockerfile --build-arg BASE_IMAGE_PHP="php:7.4.30-fpm-buster" --target dev-base --tag ghcr.io/cbrooney/base-php-fpm-dev:test
docker push ghcr.io/cbrooney/base-php-fpm-dev:test

# run dev env
#docker-compose -f docker-compose.yml -f docker-compose-db.yml --env-file .env.local.docker-compose up -d

#