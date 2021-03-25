FROM alpine:3.13.2

RUN apk update && apk add vim curl apk add openjdk8-jre mysql
