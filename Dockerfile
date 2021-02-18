FROM drupal:9-php7.4-apache
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends git
