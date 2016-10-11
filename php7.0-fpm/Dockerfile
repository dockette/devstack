FROM dockette/devstack:php7

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN apt-get update && apt-get install -y php7.0-fpm && \
    ln -s /etc/php/7.0/mods-available/devstack.ini /etc/php/7.0/fpm/conf.d/999-devstack.ini && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

ADD fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf

CMD ["php-fpm7.0", "-F"]
