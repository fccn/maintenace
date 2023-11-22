# {{ ansible_managed }}
###################################################################################################
# Makefile with helper commands to manage docker haproxy container
# Run with superuser privileges
###################################################################################################


ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

############################
# HAProxy container
############################

status: ## docker container status
	docker-compose ps
.PHONY: status

bash: ## open a bash in HAProxy container
	docker-compose exec -it maintenance bash
.PHONY: bash

logs: ## view HAProxy logs
	docker-compose logs --timestamps --follow --tail=10 maintenance
.PHONY: logs

deploy: ## Deploy the maintenance
	docker-compose up -d
.PHONY: deploy

stop: ## Stop
	docker-compose down
.PHONY: down

##################
# Healthchecks
##################
healthcheck: ## Overall healthcheck
healthcheck: \
	healthcheck-http-port \
	healthcheck-https-port
	@echo "Everything looks: OK"
.PHONY: healthcheck

healthcheck-http-port: ## Check 80 port
	@echo -n "Check HAProxy 80 port: "
	@nc -z 127.0.0.1 80
	@echo "OK"
.PHONY: healthcheck-port

healthcheck-https-port: ## Check 443 port
	@echo -n "Check HAProxy 443 port: "
	@nc -z 127.0.0.1 443
	@echo "OK"
.PHONY: healthcheck-port
