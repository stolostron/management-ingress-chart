include Configfile

CHART_NAME ?= icp-management-ingress
VERSION ?= $(shell grep version ./$(CHART_NAME)/Chart.yaml | awk '{print $$2}')
UPLOAD_VERSION ?=99.99.99
FILENAME ?= ${CHART_NAME}-${VERSION}.tgz
UPLOAD_FILENAME ?= ${CHART_NAME}-${UPLOAD_VERSION}.tgz
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

publish: build
	# We need to get the tar file, does it exist
	@echo "Version: ${VERSION}"
	if [ ! -f ./$(FILENAME) ]; then \
		echo "File not found! - exitin"; \
		exit; \
	fi
	helm package --version $(UPLOAD_VERSION) $(CHART_NAME)
	# And push it to artifactory
	curl -H 'X-JFrog-Art-Api: $(ARTIFACTORY_TOKEN)' -T $(UPLOAD_FILENAME) "https://na.artifactory.swg-devops.com/artifactory/hyc-cloud-private-integration-helm-local/$(UPLOAD_FILENAME)"
	curl -H 'X-JFrog-Art-Api: $(ARTIFACTORY_TOKEN)' -T $(FILENAME) "https://na.artifactory.swg-devops.com/artifactory/hyc-cloud-private-integration-helm-local/$(FILENAME)"
	@echo "DONE"

include Makefile.docker

include Makefile.test
