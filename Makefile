###############################################################################
# Licensed Materials - Property of IBM.
# Copyright IBM Corporation 2020. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
#
# Contributors:
#  IBM Corporation - initial API and implementation
###############################################################################

# Copyright (c) 2020 Red Hat, Inc.
# Copyright Contributors to the Open Cluster Management project

SHELL = /bin/bash
STABLE_BUILD_DIR = repo/stable
STABLE_REPO_URL ?= https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
STABLE_CHARTS := $(wildcard stable/*)
PACKAGE_VERSION ?= 3.4.0

.DEFAULT_GOAL=all

$(STABLE_BUILD_DIR):
	@mkdir -p $@

.PHONY: charts charts-stable $(STABLE_CHARTS)

# Default aliases: charts, repo

charts: charts-stable

repo: repo-stable

charts-stable: $(STABLE_CHARTS)
$(STABLE_CHARTS): $(STABLE_BUILD_DIR)
	helm package $@ -d $(STABLE_BUILD_DIR)

.PHONY: repo repo-stable repo-incubating

repo-stable: $(STABLE_CHARTS) $(STABLE_BUILD_DIR)
	helm repo index $(STABLE_BUILD_DIR) --url $(STABLE_REPO_URL)

.PHONY: all
all: repo-stable

tool:
	curl -fksSL https://storage.googleapis.com/kubernetes-helm/helm-v2.7.2-linux-amd64.tar.gz | sudo tar --strip-components=1 -xvz -C /usr/local/bin/ linux-amd64/helm

setup:
	helm init -c

build: setup
	helm package  --version $(PACKAGE_VERSION) ./stable/management-ingress/

.PHONY: release
release: build
	curl -H 'X-JFrog-Art-Api: $(ARTIFACTORY_TOKEN)' -T management-ingress-$(PACKAGE_VERSION).tgz "https://na.artifactory.swg-devops.com/artifactory/hyc-cloud-private-integration-helm-local/management-ingress-$(PACKAGE_VERSION).tgz"
