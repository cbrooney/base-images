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
