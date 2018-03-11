FROM ubuntu:12.04

RUN set -xe \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		php5-cli php5-mysql php5-curl php5-gd php5-mcrypt php5-intl \		
		php-xdebug git patch curl wget mysql-client \

	&& ( \
		echo '; Local configuration for PHP' \
		echo '; priority=99' \
		echo 'date.timezone = "UTC"' \
	) | tee /etc/php5/conf.d/local.ini \
	&& bash -x /php-qa-tools-install.sh \
	&& rm /php-qa-tools-install.sh

CMD ["php -a"]

