FROM debian:bullseye-slim@sha256:b0d53c872fd640c2af2608ba1e693cfc7dedea30abcd8f584b23d583ec6dadc7 AS base

# github metadata
LABEL org.opencontainers.image.source=https://github.com/uwcip/infrastructure-squid

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends squid squidclient prometheus-squid-exporter && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
COPY entrypoint /entrypoint
RUN chmod +x /entrypoint

HEALTHCHECK --interval=1m --timeout=3s CMD squidclient -h localhost cache_object://localhost/counters || exit 1
ENTRYPOINT ["/entrypoint"]
