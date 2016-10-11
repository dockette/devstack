# DevStack

[![Docker Stars](https://img.shields.io/docker/stars/dockette/devstack.svg?style=flat)](https://hub.docker.com/r/dockette/devstack/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/devstack.svg?style=flat)](https://hub.docker.com/r/dockette/devstack/)

Great LAMP devstack for you home programming.

## LAMP

- Apache 2.4.x
- PHP 7.0.x + Composer + PHPMailer
- PHP 5.6.x + Composer + PHPMailer
- NodeJS 6.7.x + NPM 3.10.x
- MariaDB 10.1.x

### Install

1. Download devstack bin script.

    ```
    wget https://raw.githubusercontent.com/dockette/devstack/master/devstack
    ```

2. Change variable `COMPOSE` to follow your `docker-compose.yml`.

3. Make executable

    ```sh
    chmod +x devstack
    ```

4. Make symlink to `/usr/local/bin/devstack` or to other bin path.

    ```sh
    ln -s ~/devstack /usr/local/bin/devstack
    ```

### docker-compose.yml

Prepared config file. You can download it here.

```
wget https://raw.githubusercontent.com/dockette/devstack/master/docker-compose.yml
```

### Userdirs

There are two kind of users inside containers.

**Root** and **dfx** (uid 1000).

In the docker-compose.yml is a section/container **userdirs**. On the startup, your users dir
are attached to php7, php56, nodejs containers. You should create your .bash_profile, .bashrc files 
for easy-to-use, for example bash completion.

You can copy skeleton.

```sh
cp /etc/skel/.bashrc <path-to-dfx-userdir>/.bashrc
```

### Hosts

By default is devstack available on domains:

- localhost (php)
- local.dev (php)
- www.local.dev (php)
- local.dev7 (php7)
- www.local.dev7 (php7)
- local.dev56 (php56)
- www.local.dev56 (php56)

You should add these lines to your `/etc/hosts` file.

```
127.0.0.1 local.dev
127.0.0.1	www.local.dev
127.0.0.1 local.dev7
127.0.0.1	www.local.dev7
127.0.0.1 local.dev5
127.0.0.1	www.local.dev5
```

-----

Thank you for testing, reporting and contributing.
