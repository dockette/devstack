# AGENTS.md

## Project

Dockette DevStack is a Docker Compose LAMP development stack. It combines Apache, PHP FPM, Node.js, Adminer, MariaDB, optional PostgreSQL, and user data helper containers through `docker-compose.yml` and the `devstack` control script.

## Images

- Docker Hub repository: `dockette/devstack`.
- Local image contexts live in `apache/`, `nodejs/`, and `php/*`.
- The default compose file references tags such as `dockette/devstack:apache`, `dockette/devstack:php85-fpm`, and `dockette/devstack:nodejs`.
- All images build on `dockette/debian:bookworm`. PHP comes from `packages.sury.org`, Node.js from the official `nodejs.org` tarball, and the Blackfire probe from `packages.blackfire.io`.
- Keep runtimes on current upstream versions; when bumping PHP, update `php/*` directory names, the `PHP_VERSION` env, the FPM `CMD`, the `Makefile` tag, and the compose service name together.

## Commands

- `make build` builds selected representative local images: Apache, PHP 8.5 FPM, and Node.js.
- `make test` validates `docker-compose.yml` with `docker compose config` and checks `devstack` shell syntax.
- `make run` starts the compose stack with `docker compose up -d --remove-orphans`.

## Testing Notes

- Use `make -n build test run` to inspect target wiring without requiring Docker.
- Compose validation needs `SSH_AUTH_SOCK`; the Makefile provides a safe placeholder for non-interactive checks.
- Full stack startup binds common host ports (`80`, `443`, `3306`, `8000`) and should be treated as a local/manual check.

## Guidelines

- Preserve the compose UX and documented service names unless the task explicitly asks for migration.
- Prefer small CI checks: compose config, shell syntax, and representative image builds.
- Place `.PHONY` directly above every Makefile target.
- Keep README badges in the Dockette `copybara` style and do not add Slack or Gitter badges.
- Keep the Maintenance section aligned with active Dockette Docker image repositories.
