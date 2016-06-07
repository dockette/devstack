FROM dockette/devstack:php

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ADD conf.d/devstack.ini /etc/php/mods-available/devstack.ini

RUN echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
    echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
    wget http://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg && rm dotdeb.gpg && \
    apt-get update && \
    apt-get install -y \
        php5-cli \
        php5-cgi \
        php5-curl \
        php5-imap \
        php5-pgsql \
        php5-mysql \
        php5-sqlite \
        php5-gd \
        php5-intl \
        php5-mongo \
        php5-geoip \
        php5-memcached \
        php5-mcrypt \
        php5-xsl \
        php5-imagick \
        php5-ldap \
        php5-redis \
        php5-xmlrpc \
        php5-xdebug && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    ln -s /etc/php/mods-available/devstack.ini /etc/php5/cli/conf.d/999-devstack.ini && \
    ln -s /etc/php/mods-available/devstack.ini /etc/php5/cgi/conf.d/999-devstack.ini && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

CMD ["php"]
