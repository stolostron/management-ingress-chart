include Configfile

CHART_NAME ?= icp-management-ingress

.PHONY: build lint setup

default: build

tool:
	curl -fksSL https://storage.googleapis.com/kubernetes-helm/helm-v2.7.2-linux-amd64.tar.gz | sudo tar --strip-components=1 -xvz -C /usr/local/bin/ linux-amd64/helm

setup:
	helm init -c

lint: setup
	helm lint $(CHART_NAME)

build: lint
	helm package $(CHART_NAME)

include Makefile.docker
