TAG_PREFIX ?= sambuc/renku
TAG_VERSION ?= :latest
DOCKER_PLATFORM ?= --platform linux/amd64
PUSH_IMAGE ?= false

SHELLS := \
	shell \
	shell-zsh \
	shell-lionel

XPRAS := \
	xpra \
	xpra-rxvt \
	xpra-xfce4 \
	xpra-lionel \
	xpra-knime

TAG = ${TAG_PREFIX}-$(shell echo $@|sed -e 's,-.*,,')${TAG_VERSION}$(shell echo $@|grep -o -- '-.*')

help:
	@echo show help here

all: shells xpras

shells: ${SHELLS}
xpras: ${XPRAS}

shell:
shell-zsh: shell
shell-lionel: shell-zsh

xpra:
xpra-rxvt: xpra
xpra-xfce4: xpra
xpra-lionel: xpra-xfce4
xpra-knime: xpra-xfce4
xpra-fiji: xpra-xfce4

%: Dockerfile.%
	@echo
	@echo "######## BUILDING ${@} ########"
	docker build . -f ${<} ${DOCKER_PLATFORM} -t ${TAG} --build-arg TAG_VERSION=${TAG_VERSION}
	@${PUSH_IMAGE} && echo "######## PUSHING ${TAG} ########" || true
	${PUSH_IMAGE} && docker push ${TAG} || true
