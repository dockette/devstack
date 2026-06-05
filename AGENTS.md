# AGENTS.md

## Project

Dockette DevStack is a legacy Docker Compose LAMP development stack. It combines Apache, PHP FPM, Node.js, Adminer, MariaDB, optional PostgreSQL, and user data helper containers through `docker-compose.yml` and the `devstack` control script.

## Images

- Docker Hub repository: `dockette/devstack`.
- Local image contexts live in `apache/`, `nodejs/`, and `php/*`.
- The default compose file references tags such as `dockette/devstack:apache`, `dockette/devstack:php72-fpm`, and `dockette/devstack:nodejs`.
- Base images and runtime versions are legacy; avoid broad upgrades unless explicitly requested.

## Commands

- `make build` builds selected representative local images: Apache, PHP 7.2 FPM, and Node.js.
- `make test` validates `docker-compose.yml` with `docker compose config` and checks `devstack` shell syntax.
- `make run` starts the compose stack with `docker compose up -d --remove-orphans`.

## Testing Notes

- Use `make -n build test run` to inspect target wiring without requiring Docker.
- Compose validation needs `SSH_AUTH_SOCK`; the Makefile provides a safe placeholder for non-interactive checks.
- Full stack startup binds common host ports (`80`, `443`, `3306`, `8000`) and should be treated as a local/manual check.

## Guidelines

- Preserve the legacy compose UX and documented service names unless the task explicitly asks for migration.
- Prefer small CI checks: compose config, shell syntax, and representative image builds.
- Place `.PHONY` directly above every Makefile target.
- Keep README badges in the Dockette `copybara` style and do not add Slack or Gitter badges.
- Keep the Maintenance section aligned with active Dockette Docker image repositories.
