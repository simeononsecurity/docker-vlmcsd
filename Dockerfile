FROM alpine:latest as builder
WORKDIR /root
RUN apk add --no-cache git make build-base && \
    git clone --branch master --single-branch https://github.com/Wind4/vlmcsd.git && \
    cd vlmcsd && \
    make

FROM alpine:latest

LABEL org.opencontainers.image.source="https://github.com/simeononsecurity/docker-vlmcsd"
LABEL org.opencontainers.image.description="vlmcsd is a replacement for Microsoft's KMS server."
LABEL org.opencontainers.image.authors="simeononsecurity"

COPY --from=builder /root/vlmcsd/bin/vlmcsd /vlmcsd
RUN apk add --no-cache tzdata

EXPOSE 1688/tcp

CMD ["/vlmcsd", "-D", "-d", "-t", "3", "-e", "-v"]
