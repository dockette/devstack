FROM dockette/debian:jessie

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV PHP_IDE_CONFIG="serverName=docker"
ENV XDEBUG_CONFIG="idekey=PHPSTORM"
ENV PHPMAILER_BIN=/usr/local/bin/phpmailer
ENV PHPMAILER_PATH=/srv/mails
ENV SSH_AUTH_SOCK=/ssh-agent

RUN apt-get update && apt-get update -y && \
    apt-get install -y wget curl git && \
    echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    curl -o ${PHPMAILER_BIN} https://raw.githubusercontent.com/dockette/phpmailer/master/phpmailer && \
    mkdir -p ${PHPMAILER_PATH} && \
    chmod 755 ${PHPMAILER_BIN} && \
    chmod 777 ${PHPMAILER_PATH} && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

VOLUME /srv
WORKDIR /srv
