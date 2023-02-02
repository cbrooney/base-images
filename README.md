# base-images
Base docker images for app development and prod

# structure
## dev
- Base dev image is base-php-fpm-dev:latest
- will be published after merge to main
- each branch will create a new image: base-php-fpm-dev:${branch-name}
- correlated should be also nginx for that
- creating the dev-env should be done on each host
## test
- images needed for tests should be pushed by code
- extending the images for dev
- also mounting the code and push the complete image
- should at first especially created for each code branch
## prod
- not really needed for now but will use that for testing pre prod environment
- prod-base should be pushed here
- prod env should base on that and pushed in code
## rasp
- will be created on rasp
- base-php-fpm-rasp:latest
- base-nginx-rasp:latest
- should use prod but with different architecture


# Process for updating php version => as an example for updating in general base images
- create new tag for registry in development.yaml for dev and prod
docker build . -f php-fpm/build/Dockerfile --build-arg BASE_IMAGE_PHP="php:8.0.27-fpm-buster" --target dev-base --tag ghcr.io/cbrooney/base-php-fpm-dev:8.0.27
docker push ghcr.io/cbrooney/base-php-fpm-dev:8.0.27
docker build . -f php-fpm/build/Dockerfile --build-arg BASE_IMAGE_PHP="php:8.0.27-fpm-buster" --target prod-base --tag ghcr.io/cbrooney/base-php-fpm-prod:8.0.27
docker push ghcr.io/cbrooney/base-php-fpm-prod:8.0.27
- create same tags in [publish-latest-images.yaml]
- alternatively the tags in [development.yaml] can be omitted and tag with new branch name can be used
- do not change in a first step the latest version
- use this tag in your app code
## dev
- change in [docker-compose-dev.yml] the base image tag under build => PHP_BASE_IMAGE_TAG: 8.0.27
- build dev and it is ready for development
## test
- in order to run all tests in docker image with new php version change in [development.yaml]
the build arg under `build-test-env` to desired tag `--build-arg PHP_BASE_IMAGE_TAG="8.0.27"`
- this is the config for this specific branch, see also tagging 
## prod
- same as test: 
- change in [development.yaml] the build arg under `build-prod-env` to desired tag `--build-arg PHP_BASE_IMAGE_TAG="8.0.27"`
- this is the config for this specific branch, see also tagging
- if you want to run prod mode with new and updated image, 
change in [docker-compose-prod.yml] the tag ghcr.io/cbrooney/bruni-home-app-prod:latest
- this will maybe also be replaced by argument
## rasp
### build base
- build first the new image locally
- git checkout `branch` (base-images)
- git pull
- bash scripts/build-rasp.sh
  - docker build --platform linux/arm/v7 . -f php-fpm/build/Dockerfile --build-arg BASE_IMAGE_PHP="php:8.0.27-fpm-buster" --target prod-base --tag ghcr.io/cbrooney/base-php-fpm-rasp:8.0.27
### coding with new version
- go to your app coding
- set in your app in [docker-compose-rasp.yml] the tag ghcr.io/cbrooney/bruni-home-app-rasp:8.0.27
- push
### use code on rasp
- go to rasp
- git checkout `branch` (base-images)
- git pull
- bash build-rasp.sh
- bash run-rasp.sh
  - docker compose -f docker-compose-rasp.yml -f docker-compose-db.yml --env-file .env.local.docker-compose up -d --remove-orphans
