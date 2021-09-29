DOCKER_IMAGE=openjardin

include Makefile.docker

PACKAGE_VERSION=0.1

include Makefile.package

.PHONY: check-version
check-version:
	docker run --rm --entrypoint printenv $(DOCKER_NAMESPACE)/$(DOCKER_IMAGE):$(VERSION)| grep VERSION| awk -F '=' '{print $$2}'
