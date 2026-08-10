FROM dockette/debian:bookworm

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

# SSH
ENV SSH_AUTH_SOCK=/ssh-agent

# PHP
ENV PHP_VERSION=8.5
ENV PHP_MODS_DIR=/etc/php/${PHP_VERSION}/mods-available
ENV PHP_CLI_DIR=/etc/php/${PHP_VERSION}/cli
ENV PHP_CLI_CONF_DIR=${PHP_CLI_DIR}/conf.d
ENV PHP_CGI_DIR=/etc/php/${PHP_VERSION}/cgi
ENV PHP_CGI_CONF_DIR=${PHP_CGI_DIR}/conf.d
ENV PHP_FPM_DIR=/etc/php/${PHP_VERSION}/fpm
ENV PHP_FPM_CONF_DIR=${PHP_FPM_DIR}/conf.d

# XDEBUG
ENV PHP_IDE_CONFIG="serverName=devstack.webserver"
ENV XDEBUG_CONFIG="idekey=PHPSTORM"

# MAILER
ENV PHPMAILER_BIN=/usr/local/bin/phpmailer
ENV PHPMAILER_PATH=/srv/mails

# COMPOSER
ENV COMPOSER_HOME=/root/.composer
ENV COMPOSER_ALLOW_SUPERUSER=1

# DEBUGGING
ENV BLACKFIRE_AGENT=tcp://blackfire:8707

# INSTALLATION
RUN apt-get update && apt-get dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt-get install -y --no-install-recommends \
        wget curl git bash-completion ca-certificates gnupg && \
    mkdir -p /etc/apt/keyrings && \
    # COMPLETION ###############################################################
    cp /etc/skel/.bashrc ~/ && \
    cp /etc/skel/.bashrc /home/dfx/ && chown dfx:dfx -R /home/dfx/ && \
    # SSH ######################################################################
    echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    # PHP PACKAGES.SURY.ORG ####################################################
    curl -fsSLo /etc/apt/keyrings/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/php.gpg] https://packages.sury.org/php/ bookworm main" \
        > /etc/apt/sources.list.d/php.list && \
    # BLACKFIRE PACKAGES.BLACKFIRE.IO ##########################################
    curl -fsSL https://packages.blackfire.io/gpg.key | gpg --dearmor > /etc/apt/keyrings/blackfire.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/blackfire.gpg] http://packages.blackfire.io/debian any main" \
        > /etc/apt/sources.list.d/blackfire.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        php${PHP_VERSION}-apcu \
        php${PHP_VERSION}-bcmath \
        php${PHP_VERSION}-bz2 \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-cgi \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-ldap \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-memcached \
        php${PHP_VERSION}-mongodb \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-pgsql \
        php${PHP_VERSION}-redis \
        php${PHP_VERSION}-soap \
        php${PHP_VERSION}-sqlite3 \
        php${PHP_VERSION}-xsl \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-xdebug \
        blackfire \
        blackfire-php && \
    # PHPMAILER ################################################################
    curl -fsSLo ${PHPMAILER_BIN} https://raw.githubusercontent.com/dockette/phpmailer/master/phpmailer && \
    mkdir -p ${PHPMAILER_PATH} && \
    chmod 755 ${PHPMAILER_BIN} && \
    chmod 777 ${PHPMAILER_PATH} && \
    # COMPOSER #################################################################
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require bamarni/symfony-console-autocomplete && \
    ${COMPOSER_HOME}/vendor/bin/symfony-autocomplete --shell bash composer | tee /etc/bash_completion.d/composer && \
    # BLACKFIRE ################################################################
    printf "extension=blackfire.so\nblackfire.agent_socket=${BLACKFIRE_AGENT}\n" > ${PHP_MODS_DIR}/blackfire.ini && \
    # PHP MOD(s) ###############################################################
    ln -sf ${PHP_MODS_DIR}/blackfire.ini ${PHP_CLI_CONF_DIR}/20-devstack.ini && \
    ln -sf ${PHP_MODS_DIR}/blackfire.ini ${PHP_CGI_CONF_DIR}/20-devstack.ini && \
    ln -sf ${PHP_MODS_DIR}/blackfire.ini ${PHP_FPM_CONF_DIR}/20-devstack.ini && \
    ln -sf ${PHP_MODS_DIR}/devstack.ini ${PHP_CLI_CONF_DIR}/999-devstack.ini && \
    ln -sf ${PHP_MODS_DIR}/devstack.ini ${PHP_CGI_CONF_DIR}/999-devstack.ini && \
    ln -sf ${PHP_MODS_DIR}/devstack.ini ${PHP_FPM_CONF_DIR}/999-devstack.ini && \
    # CLEAN UP #################################################################
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# FILES
COPY conf.d/devstack.ini ${PHP_MODS_DIR}/devstack.ini
COPY fpm/php-fpm.conf ${PHP_FPM_DIR}/php-fpm.conf

# WORKDIR
WORKDIR /srv

# COMMAND
CMD ["php-fpm8.5", "-F"]
