TAG_PREFIX ?= sambuc/renku
TAG_VERSION ?=
DOCKER_PLATFORM ?= --platform linux/amd64
PUSH_IMAGE ?= false

IMAGES ?= \
	base \
	zsh \
	lionel \
	xpra

all: ${IMAGES}

base:
zsh: base
lionel: zsh

%: Dockerfile.%
	@echo
	@echo "######## BUILDING ${@} ########"
	docker build . -f ${<} ${DOCKER_PLATFORM} -t ${TAG_PREFIX}-${@}${TAG_VERSION}
	@${PUSH_IMAGE} && echo "######## PUSHING ${@} ########" || true
	${PUSH_IMAGE} && docker push ${TAG_PREFIX}-${@}${TAG_VERSION} || true
