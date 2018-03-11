FROM ubuntu:16.04

RUN set -xe \
	&& echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main' > /etc/apt/sources.list.d/ondrej.list \
	&& LC_ALL=C.UTF-8 apt-key adv --recv-key --keyserver keyserver.ubuntu.com E5267A6C \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		php7.1-fpm php7.1-cli php7.1-mysql php7.1-xml php7.1-zip php7.1-curl php7.1-gd php7.1-mbstring php7.1-mcrypt \
	&& ( \
		echo '; Local configuration for PHP' \
		echo '; priority=99' \
		echo 'date.timezone = "UTC"' \
	) | tee /etc/php/7.1/mods-available/local.ini \
	&& phpenmod local \
	&& ls -la /etc/php/7.1/fpm/pool.d \
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
	) | tee /etc/php/7.1/fpm/pool.d/docker.conf \
	&& ( \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
		echo 'listen = [::]:9000'; \
	) | tee /etc/php/7.1/fpm/pool.d/zz-docker.conf \
	&& mkdir /run/php

VOLUME /var/www

EXPOSE 9000

CMD ["php-fpm7.1"]

