FROM dockette/stretch

MAINTAINER Milan Sulc <sulcmil@gmail.com>

# SSH
ENV SSH_AUTH_SOCK=/ssh-agent

# PHP
ENV PHP_MODS_DIR=/etc/php/5.6/mods-available
ENV PHP_CLI_DIR=/etc/php/5.6/cli
ENV PHP_CLI_CONF_DIR=${PHP_CLI_DIR}/conf.d
ENV PHP_CGI_DIR=/etc/php/5.6/cgi
ENV PHP_CGI_CONF_DIR=${PHP_CGI_DIR}/conf.d

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
        php5.6-apcu \
        php5.6-bcmath \
        php5.6-cli \
        php5.6-cgi \
        php5.6-curl \
        php5.6-geoip \
        php5.6-gd \
        php5.6-intl \
        php5.6-imagick \
        php5.6-imap \
        php5.6-ldap \
        php5.6-mcrypt \
        php5.6-memcached \
        php5.6-mongo \
        php5.6-mysql \
        php5.6-pgsql \
        php5.6-redis \
        php5.6-sqlite3 \
        php5.6-ssh2 \
        php5.6-xmlrpc \
        php5.6-xsl \
        php5.6-xdebug && \
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
    curl -A "Docker" -o /tmp/blackfire.so -D - -L -s https://packages.blackfire.io/binaries/blackfire-php/${BLACKFIRE_PROBE}/blackfire-php-linux_amd64-php-56.so && \
    mv /tmp/blackfire.so $(php -r "echo ini_get('extension_dir');")/blackfire.so && \
    printf "extension=blackfire.so\nblackfire.agent_socket=${BLACKFIRE_AGENT}\n" > ${PHP_MODS_DIR}/blackfire.ini && \
    curl -A "Docker" -o /usr/local/bin/blackfire -D - -L -s https://packages.blackfire.io/binaries/blackfire-agent/${BLACKFIRE_CLI}/blackfire-cli-linux_static_amd64 && \
    chmod +x /usr/local/bin/blackfire && \
    # PHP MOD(s) ###############################################################
    ln -s ${PHP_MODS_DIR}/blackfire.ini ${PHP_CLI_CONF_DIR}/20-devstack.ini && \
    ln -s ${PHP_MODS_DIR}/blackfire.ini ${PHP_CGI_CONF_DIR}/20-devstack.ini && \
    ln -s ${PHP_MODS_DIR}/devstack.ini ${PHP_CLI_CONF_DIR}/999-devstack.ini && \
    ln -s ${PHP_MODS_DIR}/devstack.ini ${PHP_CGI_CONF_DIR}/999-devstack.ini && \
    # CLEAN UP #################################################################
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# FILES
ADD conf.d/devstack.ini ${PHP_MODS_DIR}/devstack.ini

# WORKDIR
WORKDIR /srv

# COMMAND
CMD ["php"]
