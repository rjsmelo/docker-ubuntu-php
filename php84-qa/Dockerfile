FROM ubuntu:20.04

ENV PHP_VERSION=8.4

COPY php-qa-tools-install.sh /php-qa-tools-install.sh

RUN set -xe \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common\
	&& DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		php${PHP_VERSION}-cli php${PHP_VERSION}-mysql php${PHP_VERSION}-xml php${PHP_VERSION}-zip php${PHP_VERSION}-bz2 php${PHP_VERSION}-curl php${PHP_VERSION}-gd php${PHP_VERSION}-mbstring php${PHP_VERSION}-intl php${PHP_VERSION}-ldap php${PHP_VERSION}-bcmath php${PHP_VERSION}-soap \
		git patch curl wget mysql-client unzip zip bzip2 \
	&& ( \
		echo '; Local configuration for PHP' \
		echo '; priority=99' \
		echo 'date.timezone = "UTC"' \
	) | tee /etc/php/${PHP_VERSION}/mods-available/local.ini \
	&& phpenmod local \
	&& bash -x /php-qa-tools-install.sh \
	&& rm /php-qa-tools-install.sh

CMD ["php", "-a"]

