FROM ubuntu:16.04

COPY php-qa-tools-install.sh /php-qa-tools-install.sh

RUN set -xe \
	&& echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main' > /etc/apt/sources.list.d/ondrej.list \
	&& LC_ALL=C.UTF-8 apt-key adv --recv-key --keyserver keyserver.ubuntu.com E5267A6C \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		php5.6-cli php5.6-mysql php5.6-xml php5.6-zip php5.6-bz2 php5.6-curl php5.6-gd php5.6-mbstring php5.6-mcrypt php5.6-intl \
		php-xdebug git patch curl wget mysql-client unzip zip bzip2 \
	&& ( \
		echo '; Local configuration for PHP' \
		echo '; priority=99' \
		echo 'date.timezone = "UTC"' \
	) | tee /etc/php/5.6/mods-available/local.ini \
	&& phpenmod local \
	&& bash -x /php-qa-tools-install.sh \
	&& rm /php-qa-tools-install.sh

CMD ["php -a"]

