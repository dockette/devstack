FROM dockette/jessie

MAINTAINER Milan Sulc <sulcmil@gmail.com>

# SSH
ENV SSH_AUTH_SOCK=/ssh-agent

# PHP
ENV PHP_MODS_DIR=/etc/php/7.0/mods-available
ENV PHP_CLI_DIR=/etc/php/7.0/cli/
ENV PHP_CLI_CONF_DIR=${PHP_CLI_DIR}/conf.d
ENV PHP_CGI_DIR=/etc/php/7.0/cgi/
ENV PHP_CGI_CONF_DIR=${PHP_CGI_DIR}/conf.d
ENV PHP_FPM_DIR=/etc/php/7.0/fpm/
ENV PHP_FPM_CONF_DIR=${PHP_FPM_DIR}/conf.d

# XDEBUG
ENV PHP_IDE_CONFIG="serverName=devstack.webserver"
ENV XDEBUG_CONFIG="idekey=PHPSTORM"

# MAILER
ENV PHPMAILER_BIN=/usr/local/bin/phpmailer
ENV PHPMAILER_PATH=/srv/mails

# DEBUGGING
ENV BLACKFIRE_AGENT=tcp://blackfire:8707
ENV BLACKFIRE_VERSION=1.9.1

# INSTALLATION
RUN apt-get update && apt-get dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt-get install -y wget curl git bash-completion && \
    # COMPLETION ###############################################################
    cp /etc/skel/.bashrc ~/ && \
    cp /etc/skel/.bashrc /home/dfx/ && chown dfx:dfx -R /home/dfx/ && \
    # SSH ######################################################################
    echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    # PHP DOTDEB ###############################################################
    echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
    echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
    wget http://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg && rm dotdeb.gpg && \
    apt-get update && \
    apt-get install -y \
        php7.0-apc \
        php7.0-apcu \
        php7.0-bz2 \
        php7.0-cli \
        php7.0-cgi \
        php7.0-curl \
        php7.0-fpm \
        php7.0-geoip \
        php7.0-gd \
        php7.0-intl \
        php7.0-imagick \
        php7.0-imap \
        php7.0-ldap \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-memcached \
        php7.0-mongo \
        php7.0-mysql \
        php7.0-pgsql \
        php7.0-redis \
        php7.0-soap \
        php7.0-sqlite \
        php7.0-ssh2 \
        php7.0-zip \
        php7.0-xmlrpc \
        php7.0-xsl \
        php7.0-xdebug && \
    # PHPMAILER ################################################################
    curl -o ${PHPMAILER_BIN} https://raw.githubusercontent.com/dockette/phpmailer/master/phpmailer && \
    mkdir -p ${PHPMAILER_PATH} && \
    chmod 755 ${PHPMAILER_BIN} && \
    chmod 777 ${PHPMAILER_PATH} && \
    # COMPOSER #################################################################
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require "hirak/prestissimo:^0.3" && \
    composer global require bamarni/symfony-console-autocomplete && \
    ~/.composer/vendor/bin/symfony-autocomplete --shell bash composer | tee /etc/bash_completion.d/composer && \
    # BLACKFIRE ################################################################
    curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/70 && \
    tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so && \
    printf "extension=blackfire.so\nblackfire.agent_socket=${BLACKFIRE_AGENT}\n" > ${PHP_MODS_DIR}/blackfire.ini && \
    curl -A "Docker" -o /usr/local/bin/blackfire -D - -L -s https://packages.blackfire.io/binaries/blackfire-agent/${BLACKFIRE_VERSION}/blackfire-cli-linux_static_amd64 && \
    chmod +x /usr/local/bin/blackfire && \
    # PHP MOD(s) ###############################################################
    ln -s ${PHP_MODS_DIR}/blackfire.ini ${PHP_CLI_CONF_DIR}/20-devstack.ini && \
    ln -s ${PHP_MODS_DIR}/blackfire.ini ${PHP_CGI_CONF_DIR}/20-devstack.ini && \
    ln -s ${PHP_MODS_DIR}/blackfire.ini ${PHP_FPM_CONF_DIR}/20-devstack.ini && \
    ln -s ${PHP_MODS_DIR}/devstack.ini ${PHP_CLI_CONF_DIR}/999-devstack.ini && \
    ln -s ${PHP_MODS_DIR}/devstack.ini ${PHP_CGI_CONF_DIR}/999-devstack.ini && \
    ln -s ${PHP_MODS_DIR}/devstack.ini ${PHP_FPM_CONF_DIR}/999-devstack.ini && \
    # CLEAN UP #################################################################
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# FILES
ADD conf.d/devstack.ini ${PHP_MODS_DIR}/devstack.ini
ADD fpm/php-fpm.conf ${PHP_FPM_DIR}/php-fpm.conf

# WORKDIR
WORKDIR /srv

# COMMAND
CMD ["php-fpm7.0", "-F"]
