FROM php:fpm

ARG appname
ENV SWOOLE_HTTP_PORT ${SWOOLE_HTTP_PORT:-80}
ENV SWOOLE_HTTP_HOST ${SWOOLE_HTTP_HOST:-"0.0.0.0"}
ENV APP_NAME $appname

RUN apt-get update

RUN apt-get install vim -y && \
    apt-get install openssl -y && \
    apt-get install libssl-dev -y && \
    apt-get install wget -y 

RUN cd /tmp && wget https://pecl.php.net/get/swoole-4.2.9.tgz && \
    tar zxvf swoole-4.2.9.tgz && \
    cd swoole-4.2.9  && \
    phpize  && \
    ./configure  --enable-openssl && \
    make && make install

RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo_pgsql pgsql

RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
    echo 'extension=swoole.so' > /usr/local/etc/php/conf.d/swoole.ini

USER root

# Clean up apt cache and temp files to save disk space
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./ /var/www

WORKDIR /var/www/${APP_NAME}

EXPOSE 80
