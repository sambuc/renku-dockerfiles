ARG BASE_IMAGE="sambuc/renku-base:latest"
FROM ${BASE_IMAGE}

SHELL ["/bin/sh", "-c"]
USER root

# LSA: Bare minimum tools to get to a working environment
RUN apk add --no-cache zsh tree bat dust openssh git git-lfs vim htop

# LSA: Set zsh as login shell
RUN sed -e '/^renku/s,bash,zsh,' -i /etc/passwd

USER renku
