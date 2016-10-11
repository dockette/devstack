FROM dockette/devstack:php

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ADD conf.d/devstack.ini /etc/php/7.0/mods-available/devstack.ini

RUN echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
    echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
    wget http://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg && rm dotdeb.gpg && \
    apt-get update && \
    apt-get install -y \
        php7.0-cli \
        php7.0-cgi \
        php7.0-curl \
        php7.0-imap \
        php7.0-pgsql \
        php7.0-mysql \
        php7.0-sqlite \
        php7.0-gd \
        php7.0-intl \
        php7.0-mongo \
        php7.0-geoip \
        php7.0-memcached \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-xsl \
        php7.0-imagick \
        php7.0-ldap \
        php7.0-redis \
        php7.0-xmlrpc \
        php7.0-bz2 \
        php7.0-ssh2 \
        php7.0-zip \
        php7.0-apcu \
        php7.0-xdebug && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require "hirak/prestissimo:^0.3" \
    ln -s /etc/php/7.0/mods-available/devstack.ini /etc/php/7.0/cli/conf.d/999-devstack.ini && \
    ln -s /etc/php/7.0/mods-available/devstack.ini /etc/php/7.0/cgi/conf.d/999-devstack.ini && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

CMD ["php"]
