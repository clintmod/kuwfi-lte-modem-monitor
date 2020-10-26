FROM alpine:latest

RUN apk add --update --no-cache --purge bash busybox-extras expect \
  && rm -rf /var/cache/apk/* /tmp/*

RUN sed -i 's#/root:/bin/ash#/root:/bin/bash#g' /etc/passwd

WORKDIR /app

ENV APP_HOME=/app

COPY . .

CMD scripts/run.sh
