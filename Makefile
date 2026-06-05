DOCKER_IMAGE=dockette/devstack
DOCKER_PLATFORMS?=linux/amd64
COMPOSE?=docker compose
COMPOSE_FILE?=docker-compose.yml
COMPOSE_SSH_AUTH_SOCK?=/tmp/devstack-ssh-agent

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:apache apache
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:php72-fpm php/7.2-fpm
	docker buildx build --platform ${DOCKER_PLATFORMS} -t ${DOCKER_IMAGE}:nodejs nodejs

.PHONY: test
test:
	SSH_AUTH_SOCK=${COMPOSE_SSH_AUTH_SOCK} ${COMPOSE} -f ${COMPOSE_FILE} config
	bash -n devstack

.PHONY: run
run:
	SSH_AUTH_SOCK=$${SSH_AUTH_SOCK:-${COMPOSE_SSH_AUTH_SOCK}} ${COMPOSE} -f ${COMPOSE_FILE} up -d --remove-orphans
