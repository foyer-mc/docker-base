ARG ALPINE_VERSION=3.10

FROM alpine:$ALPINE_VERSION

ARG JRE_VERSION=11
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.schema-version="1.0.0" \
      org.label-schema.name=base \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://git.foyer.cool/docker-base" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.java.version=$JRE_VERSION

RUN apk add --no-cache su-exec sudo shadow curl expect perl dumb-init
ENTRYPOINT [ "dumb-init" ]

# MC user
RUN useradd -u 10000 -G wheel -p '!' -d /minecraft minecraft \
 && install -m 700 -o minecraft -g minecraft -d /minecraft

# Java
RUN apk add --no-cache openjdk${JRE_VERSION}-jre-headless

USER minecraft
WORKDIR /minecraft
