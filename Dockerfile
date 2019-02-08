FROM wayneintacart/mage-ready

MAINTAINER Wayne Theisinger <wayne@mowdirect.co.uk>

RUN apt-get update \
  && apt-get install -y \
    git && \
    apt-get clean

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser -d /home/appuser && \
    usermod -G www-data appuser

RUN mkdir /home/appuser && chown appuser:appuser /home/appuser
COPY --from=composer:1.8.3 /usr/bin/composer /usr/bin/composer

COPY composer.json /src/composer.json

RUN chown -R appuser:appuser /src

USER appuser

ENV COMPOSER_VERSION 1.8.3

RUN composer install 2>&1

ENV PATH $PATH:/src/vendor/bin

WORKDIR /src

ENTRYPOINT ["behat"]
