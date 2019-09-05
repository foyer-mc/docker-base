ARG ALPINE_VERSION=3.10

FROM alpine:$ALPINE_VERSION

ARG JRE_VERSION=11

RUN apk add --no-cache su-exec sudo shadow curl expect perl dumb-init
ENTRYPOINT [ "dumb-init" ]

# MC user
RUN useradd -u 10000 -G wheel -p '!' -d /minecraft minecraft \
 && install -m 700 -o minecraft -g minecraft -d /minecraft

# Java
RUN apk add --no-cache openjdk${JRE_VERSION}-jre-headless

USER minecraft
WORKDIR /minecraft
