FROM dockette/stretch

MAINTAINER Milan Sulc <sulcmil@gmail.com>

# SSH
ENV SSH_AUTH_SOCK=/ssh-agent

# PHP
ENV PHP_MODS_DIR=/etc/php/7.1/mods-available
ENV PHP_CLI_DIR=/etc/php/7.1/cli
ENV PHP_CLI_CONF_DIR=${PHP_CLI_DIR}/conf.d
ENV PHP_CGI_DIR=/etc/php/7.1/cgi
ENV PHP_CGI_CONF_DIR=${PHP_CGI_DIR}/conf.d
ENV PHP_FPM_DIR=/etc/php/7.1/fpm
ENV PHP_FPM_CONF_DIR=${PHP_FPM_DIR}/conf.d

# XDEBUG
ENV PHP_IDE_CONFIG="serverName=devstack.webserver"
ENV XDEBUG_CONFIG="idekey=PHPSTORM"

# MAILER
ENV PHPMAILER_BIN=/usr/local/bin/phpmailer
ENV PHPMAILER_PATH=/srv/mails

# DEBUGGING
ENV BLACKFIRE_AGENT=tcp://blackfire:8707
ENV BLACKFIRE_CLI=1.17.0
ENV BLACKFIRE_PROBE=1.20.0

# INSTALLATION
RUN apt update && apt dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt install -y wget curl git bash-completion apt-transport-https ca-certificates && \
    # COMPLETION ###############################################################
    cp /etc/skel/.bashrc ~/ && \
    cp /etc/skel/.bashrc /home/dfx/ && chown dfx:dfx -R /home/dfx/ && \
    # SSH ######################################################################
    echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    # PHP DEB.SURY.CZ ##########################################################
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list && \
    apt update && \
    apt install -y --no-install-recommends \
        php7.1-apc \
        php7.1-apcu \
        php7.1-bcmath \
        php7.1-bz2 \
        php7.1-cli \
        php7.1-cgi \
        php7.1-curl \
        php7.1-fpm \
        php7.1-geoip \
        php7.1-gd \
        php7.1-intl \
        php7.1-imagick \
        php7.1-imap \
        php7.1-ldap \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-memcached \
        php7.1-mongo \
        php7.1-mysql \
        php7.1-pgsql \
        php7.1-redis \
        php7.1-soap \
        php7.1-sqlite3 \
        php7.1-ssh2 \
        php7.1-zip \
        php7.1-xmlrpc \
        php7.1-xsl \
        php7.1-xdebug && \
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
    curl -A "Docker" -o /tmp/blackfire.so -D - -L -s https://packages.blackfire.io/binaries/blackfire-php/${BLACKFIRE_PROBE}/blackfire-php-linux_amd64-php-71.so && \
    mv /tmp/blackfire.so $(php -r "echo ini_get('extension_dir');")/blackfire.so && \
    printf "extension=blackfire.so\nblackfire.agent_socket=${BLACKFIRE_AGENT}\n" > ${PHP_MODS_DIR}/blackfire.ini && \
    curl -A "Docker" -o /usr/local/bin/blackfire -D - -L -s https://packages.blackfire.io/binaries/blackfire-agent/${BLACKFIRE_CLI}/blackfire-cli-linux_static_amd64 && \
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
CMD ["php-fpm7.1", "-F"]
