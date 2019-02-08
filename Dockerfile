FROM wayneintacart/mage-ready

MAINTAINER Wayne Theisinger <wayne@mowdirect.co.uk>

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser -d /home/appuser && \
    usermod -G www-data appuser

RUN mkdir /home/appuser && chown appuser:appuser /home/appuser
COPY --from=composer:1.8.3 /usr/bin/composer /usr/bin/composer

ENV COMPOSER_VERSION 1.8.3

COPY composer.json /opt/behat/composer.json

RUN \
	# Install Behat
	cd /opt/behat && \
	composer install 2>&1

ENV PATH $PATH:/opt/behat/bin

WORKDIR /src

ENTRYPOINT ["behat"]
