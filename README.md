# DevStack

Great LAMP devstack based on **Docker** & **Docker Compose** for you home programming.

[![Docker Stars](https://img.shields.io/docker/stars/dockette/devstack.svg?style=flat)](https://hub.docker.com/r/dockette/devstack/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/devstack.svg?style=flat)](https://hub.docker.com/r/dockette/devstack/)

## Discussion / Help

[![Join the chat](https://img.shields.io/gitter/room/dockette/dockette.svg?style=flat-square)](https://gitter.im/dockette/dockette?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## LAMP

- Apache 2.4.x
- PHP 7.1 + Composer + PHPMailer
- PHP 5.6 + Composer + PHPMailer
- NodeJS 6.7.x + NPM 3.10.x
- MariaDB 10.1
- PostgreSQL 9.6
- Adminer 4.2.5

## Install

1. Download devstack binary script.

    ```
    wget https://raw.githubusercontent.com/dockette/devstack/master/devstack
    ```

2. Setup devstack variables in your `.profile` or `.bashrc`.
	
	- `DEVSTACK_DOCKER=~/.devstack/docker-compose.yaml` (docker compose file)
	- `DEVSTACK_PREFIX=devstack` (container's prefix)
	- `DEVSTACK_USER=dfx` (attached user in container) [you can leave it]

3. Make `devstack` manage script executable.

    ```sh
    chmod +x devstack
    ```

4. Make symlink to `/usr/local/bin/devstack` or to other bin path.

    ```sh
    ln -s ~/devstack /usr/local/bin/devstack
    ```

## Configuration

### Docker Compose (`docker-compose.yml`)

I have prepared docker configuration file for you. You can [download it here](https://github.com/dockette/devstack/blob/master/docker-compose.yml).

```
wget https://raw.githubusercontent.com/dockette/devstack/master/docker-compose.yml
```

If you didn't change the `DEVSTACK_DOCKER` variable, you should place your `docker-compose.yml` file to your user's folder `~/.devstack/docker-compose.yml`.

After you've followed install section, your devstack should be well prepared. One thing left, you should configure your devstack (passwords, folders, etc). 

You should: 
 - setup your [**data homeland**](https://github.com/dockette/devstack/blob/master/docker-compose.yml#L100-L102)
 - setup MySQL [**root password**](https://github.com/dockette/devstack/blob/master/docker-compose.yml#L71-L73)
 - setup PostgreSQL [**root password**](https://github.com/dockette/devstack/blob/master/docker-compose.yml#L93-L95)

### Userdirs

There are two kind of users inside these containers, **root** (main unix user) and **dfx** (special user with uid 1000 in all `dockette` based images).

You can find it in docker-compose.yml [file in section/container](https://github.com/dockette/devstack/blob/master/docker-compose.yml#L107-L113).

On the containers startup, your `users dir` are attached to `php7`, `php56`, `nodejs` containers. You could create your own `.bash_profile`, `.bashrc` files 
for easier manipulation inside docker containers.

[**TIP**] There used to be a skeleton in ubuntu/debian/mint system. 

```sh
cp /etc/skel/.bashrc <path-to-dfx-userdir>/.bashrc
```

### PHP

PHP container provide a few environment variables you can override: 

#### `xdebug`

| Key               | Value                          |
|-------------------|--------------------------------|
| `PHP_IDE_CONFIG`  | serverName=devstack.webserver  |
| `XDEBUG_CONFIG`   | idekey=PHPSTORM                |

#### `phpmailer`

Phpmailer store all mails send via `mail()` function to `/srv/mail` folder by default. You can change it.

| Key               | Value      |
|-------------------|------------|
| `PHPMAILER_PATH`  | /srv/mail  |

### MySQL / MariaDB

MariaDB's default root password is `root`. You should change it.

### PostgreSQL

PostgreSQL's default root password is `root`. You should change it.

## Hosts

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
127.0.0.1 www.local.dev
127.0.0.1 local.dev7
127.0.0.1 www.local.dev7
127.0.0.1 local.dev5
127.0.0.1 www.local.dev5
```

-----

Thank you for testing, reporting and contributing.
