# DevStack

[![Docker Stars](https://img.shields.io/docker/stars/dockette/devstack.svg?style=flat)](https://hub.docker.com/r/dockette/devstack/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/devstack.svg?style=flat)](https://hub.docker.com/r/dockette/devstack/)

Great LAMP devstack for you home programming.

## LAMP

- Apache >= 2.4.10
- PHP
   - >= 7.0.x
   - >= 5.6.
   - PHPMailer
   - NodeJS 5.x + NPM (Gulp, Grunt)
   - Composer
- MariaDB >= 10.1.x

## Bin

```sh
Usage: devstack [-h]

Control your devstack.

Version: 1.0

Options:

  -h          Display this help and exit.

Commands:
  up          Start the devstack.
  build       Build the devstack.
  reup        Build & Start the devstack.
  stop        Stop the devstack.
  die         Destroy the devstack.
  logs        Follow the devstack logs.
  exec        Exec command in container.
  g|go        Attach container in devstack.
  gu|gou      Attach container in devstack as user.
```

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

Prepared config file. You can download it.

```
wget https://raw.githubusercontent.com/dockette/devstack/master/docker-compose.yml
```

#### Hosts

By default is devstack available on domains:

- localhost (php)
- local.dev (php)
- local.dev7 (php7)
- local.dev56 (php56)

You should add these lines to your `/etc/hosts` file.

```
127.0.0.1	local.dev
127.0.0.1	local.dev7
127.0.0.1	local.dev5
```

-----

Thank you for testing, reporting and contributing.
