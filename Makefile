# 编译相关
FLAGS=-tags=jsoniter
DEV_FLAGS=-gcflags="-l -N" -race
GOOS=linux
GOARCH=amd64

# 项目相关
NAME=java-web-vue-base
#PORT=9088
COMMIT=$(shell git log -1 --pretty=format:%h)
DEV_NAME=$(NAME)-$(COMMIT)
RELEASE_VERSION=$(shell git describe --tags `git rev-list --tags --max-count=1`)
#RELEASE_NAME=$(NAME)-$(RELEASE_VERSION)
ifdef VERSION
RELEASE_VERSION=$(VERSION)
endif

# docker相关
DOCKER_REGISTRY=10.236.101.13:8443/common
DOCKER_TARGET=$(DOCKER_REGISTRY)/$(NAME):$(RELEASE_VERSION)

.PHONY: all
all: build-dev

build-release:
	@cnpm install
	@cnpm run build
	@echo "==================$(NAME) build okay=================="

clean:
	@rm -rf ./dist
	@echo "==================clean okay=================="

docker-build: clean
	@docker buildx build --platform linux/amd64 --no-cache -t $(DOCKER_TARGET) --build-arg modeenv=$(ENV_SERVER_MODE) --build-arg procname=$(NAME) .
	@echo "==================docker-build okay=================="

docker-build-new: clean build-release
	@docker buildx build --platform linux/amd64 --no-cache -f ./Dockerfile.pro -t $(DOCKER_TARGET) --build-arg modeenv=$(ENV_SERVER_MODE) --build-arg procname=$(NAME) .
	@echo "==================docker-build1 okay=================="

docker-push:
	docker push $(DOCKER_TARGET)
	@echo "==================docker-push okay=================="

docker-all: docker-build docker-push
	@echo "==================docker-all okay=================="

build-all: docker-build-new docker-push
	@echo "==================build-all okay=================="
