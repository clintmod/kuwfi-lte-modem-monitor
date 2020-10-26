export

SHELL = /usr/bin/env bash

DEPLOY_ENV ?= local

local_DOCKER_HOST ?= unix:///var/run/docker.sock
farm_DOCKER_HOST ?= ssh://raspberrypi.farm
DOCKER_HOST ?= $($(DEPLOY_ENV)_DOCKER_HOST)


build:
	docker build -t clintmod/kuwfi-monitor:latest .


run:
	docker run --rm -it -e HOST=192.168.100.1 clintmod/kuwfi-monitor:latest


bash:
	docker run --rm -it -e HOST=192.168.100.1 clintmod/kuwfi-monitor:latest bash	


push:
	docker push clintmod/kuwfi-monitor:latest


logs:
	docker service logs -f kuwfi-monitor_kuwfi-monitor


deploy:
	docker stack deploy --resolve-image=never \
		-c stacks/$$DEPLOY_ENV/docker-compose.yml \
		kuwfi-monitor


undeploy:
	docker stack rm kuwfi-monitor
