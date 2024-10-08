FROM ubuntu:20.04

ENV PHP_VERSION=8.4

RUN set -xe \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common\
	&& DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		php${PHP_VERSION}-cli php${PHP_VERSION}-mysql php${PHP_VERSION}-xml php${PHP_VERSION}-zip php${PHP_VERSION}-bz2 php${PHP_VERSION}-curl php${PHP_VERSION}-gd php${PHP_VERSION}-mbstring php${PHP_VERSION}-intl php${PHP_VERSION}-ldap php${PHP_VERSION}-bcmath php${PHP_VERSION}-soap \
		php${PHP_VERSION}-fpm \
	&& ( \
		echo '; Local configuration for PHP' \
		echo '; priority=99' \
		echo 'date.timezone = "UTC"' \
	) | tee /etc/php/${PHP_VERSION}/mods-available/local.ini \
	&& phpenmod local \
	&& ls -la /etc/php/${PHP_VERSION}/fpm/pool.d \
	&& ( \
		echo '[global]'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; \
		echo '[www]'; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
	) | tee /etc/php/${PHP_VERSION}/fpm/pool.d/docker.conf \
	&& ( \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
		echo 'listen = [::]:9000'; \
	) | tee /etc/php/${PHP_VERSION}/fpm/pool.d/zz-docker.conf \
	&& mkdir /run/php

VOLUME /var/www

EXPOSE 9000

CMD ["sh", "-c", "php-fpm${PHP_VERSION}"]

