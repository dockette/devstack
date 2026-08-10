<h1 align=center>Dockette / DevStack</h1>

<p align=center>
   <a href="https://github.com/dockette/devstack/actions"><img src="https://github.com/dockette/devstack/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/devstack"><img src="https://img.shields.io/docker/pulls/dockette/devstack.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

Great LAMP devstack based on **Docker** & **Docker Compose** for your home programming.

## LAMP

- Apache 2.4.x
- PHP 8.5.x + Composer + PHPMailer
- MariaDB 12.3
- Adminer (see [dockette/adminer](https://github.com/dockette/adminer))

Optional services are prepared in `docker-compose.yml`, but are commented out until you enable them:

- NodeJS 24.x (latest LTS) + NPM
- PostgreSQL 18

## Install

1. Download devstack binary script.

    ```
    wget https://raw.githubusercontent.com/dockette/devstack/master/devstack
    wget https://raw.githubusercontent.com/dockette/devstack/master/docker-compose.yml
    ```

2. Setup devstack variables in your `.profile` or `.bashrc`.
	
    > These values are default!

	- `DEVSTACK_DOCKER=~/.devstack/docker-compose.yml` (docker compose file)
	- `DEVSTACK_PREFIX=devstack` (container's prefix)
	- `DEVSTACK_USER=dfx` (attached user in container) [you can leave it]
	- `DEVSTACK_COMPOSE` (optional compose command override; defaults to `docker compose` with `docker-compose` fallback)

    The compose file mounts your SSH agent into containers, so `SSH_AUTH_SOCK` should point to a running SSH agent socket. If you do not use agent forwarding, the `devstack` script uses `/tmp/devstack-ssh-agent` as a fallback; override it with `DEVSTACK_SSH_AUTH_SOCK` if needed.

3. Make `devstack` managing script executable.

    ```sh
    chmod +x devstack
    ```

4. Create symlink to `/usr/local/bin/devstack` or to other bin path.

    ```sh
    ln -s ~/devstack /usr/local/bin/devstack
    ```

## Configuration

### Ports

| Container                | Ports    | IP           |
|--------------------------|----------|--------------|
| Apache                   | 80 / 443 | 172.10.10.5  |
| PHP 8.5 + FPM            |          | 172.10.10.10 |
| NodeJS (optional)        |          | 172.10.10.12 |
| Adminer                  | 8000     | 172.10.10.13 |
| MariaDB                  | 3306     | 172.10.10.20 |
| PostgreSQL (optional)    | 5432     | 172.10.10.21 |

### Docker Compose (`docker-compose.yml`)

I have prepared docker configuration file for you. You can [download it here](https://github.com/dockette/devstack/blob/master/docker-compose.yml). The project uses the Docker Compose plugin command (`docker compose`) and keeps a legacy `docker-compose` fallback for older hosts.

```
wget https://raw.githubusercontent.com/dockette/devstack/master/docker-compose.yml
```

If you didn't change the `DEVSTACK_DOCKER` variable, you should place your `docker-compose.yml` file to your user's folder `~/.devstack/docker-compose.yml`.

After you've followed install section, your devstack should be well prepared. One thing left, you should configure your devstack (passwords, folders, etc). 

You should: 
 - setup your [**data homeland**](https://github.com/dockette/devstack/blob/master/docker-compose.yml#L130-L131)
 - setup MySQL [**root password**](https://github.com/dockette/devstack/blob/master/docker-compose.yml#L104-L105)
 - setup PostgreSQL [**root password**](https://github.com/dockette/devstack/blob/master/docker-compose.yml#L123-L124) if you enable PostgreSQL

### Userdirs

There are two kind of users inside these containers, **root** (main unix user) and **dfx** (special user with uid 1000 in all `dockette` based images).

You can find it in docker-compose.yml [file in section/container](https://github.com/dockette/devstack/blob/master/docker-compose.yml#L134-L144).

On the containers startup, your `users dir` are attached to `php85` and to `nodejs` when you enable that optional container. You can create your own `.bash_profile`, `.bashrc` files
for easier manipulation inside docker containers.

[**TIP**] There used to be a skeleton in ubuntu/debian/mint system. 

```sh
cp /etc/skel/.bashrc <path-to-dfx-userdir>/.bashrc
```

### PHP

PHP container provides a few environment variables you can override: 

#### `xdebug`

| Key               | Value                          |
|-------------------|--------------------------------|
| `PHP_IDE_CONFIG`  | serverName=devstack.webserver  |
| `XDEBUG_CONFIG`   | idekey=PHPSTORM                |

#### `phpmailer`

Phpmailer stores all mails send via `mail()` function to `/srv/mail` folder by default. You can change it.

| Key               | Value      |
|-------------------|------------|
| `PHPMAILER_PATH`  | /srv/mail  |

### MySQL / MariaDB

MariaDB's default root password is `root`. You should change it.

You have to setup in you application/configs proper `host` which is `mariadb`. 

MariaDB container has predefined IP address `172.10.10.20`.

```
172.10.10.20 mariadb
```

### PostgreSQL (optional)

If you enable PostgreSQL, its default root password is `root`. You should change it.

You have to setup in you application/configs proper `host` which is `postgresql`. 

PostgreSQL container has predefined IP address `172.10.10.21`. You could update your `/etc/hosts`.

```
172.10.10.21 postgresql
```

### Adminer

Adminer is great tool for managing database. Dockette devstack runs `Adminer` on port `8000`.

See more on documentation at https://github.com/dockette/adminer.

## Hosts

By default is devstack available on domains:

- localhost (php)
- local.dev (php)
- www.local.dev (php)
- local.dev8 (php8)
- www.local.dev8 (php8)

You should add these lines to your `/etc/hosts` file.

```
# Devstack [webserver]
127.0.0.1 local.dev
127.0.0.1 www.local.dev
127.0.0.1 local.dev8
127.0.0.1 www.local.dev8

# Devstack [DB]
172.10.10.20 mariadb
# Optional PostgreSQL
172.10.10.21 postgresql
```

Give a try!

```
ping local.dev
ping local.dev8
ping mariadb

# Optional services
ping postgresql
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
