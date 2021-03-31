APP_VER ?= v2.25.0
APP_MINOR_VER ?= $(shell echo "${APP_VER}" | grep -oE '^v[0-9]+\.[0-9]+')

TAG ?= $(APP_MINOR_VER)

ALPINE_VER ?= 3.13

ifeq ($(BASE_IMAGE_STABILITY_TAG),)
    BASE_IMAGE_TAG := $(ALPINE_VER)
else
    BASE_IMAGE_TAG := $(ALPINE_VER)-$(BASE_IMAGE_STABILITY_TAG)
endif

REPO = wodby/prometheus
NAME = prometheus-$(APP_MINOR_VER)

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

default: build

build:
	docker build -t $(REPO):$(TAG) \
        --build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
	    --build-arg APP_VER=$(APP_VER) ./
.PHONY: build

push:
	docker push $(REPO):$(TAG)
.PHONY: push

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash
.PHONY: shell

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)
.PHONY: run

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)
.PHONY: start

stop:
	docker stop $(NAME)
.PHONY: stop

logs:
	docker logs $(NAME)
.PHONY: logs

clean:
	-docker rm -f $(NAME)
.PHONY: clean

release: build push
.PHONY: release