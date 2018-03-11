FROM ubuntu:12.04

RUN set -xe \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		php5-cli php5-mysql php5-curl php5-gd php5-mcrypt php5-intl \
		php5-fpm \
	&& ( \
		echo '; Local configuration for PHP' \
		echo '; priority=99' \
		echo 'date.timezone = "UTC"' \
	) | tee /etc/php5/conf.d/local.ini \
	&& ls -la /etc/php5/fpm/pool.d \
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
	) | tee /etc/php5/fpm/pool.d/docker.conf \
	&& ( \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
		echo 'listen = [::]:9000'; \
	) | tee /etc/php5/fpm/pool.d/zz-docker.conf \
	&& mkdir /run/php

VOLUME /var/www

EXPOSE 9000

CMD ["php5-fpm"]

