FROM dockette/debian:bookworm

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

# NODEJS (latest LTS)
ENV NODE_VERSION=24.19.0

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y wget curl git bash-completion gnupg2 openssh-client && \
    curl -fsSLo /tmp/node.tar.gz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" && \
    tar -xzf /tmp/node.tar.gz -C /usr/local --strip-components=1 --no-same-owner && \
    rm /tmp/node.tar.gz /usr/local/CHANGELOG.md /usr/local/LICENSE /usr/local/README.md && \
    npm completion >> /etc/bash_completion.d/npm && \
    npm install -g gulp-cli grunt-cli && \
    apt-get remove -y curl && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

WORKDIR /srv

CMD /bin/bash
