FROM debian:bullseye-slim@sha256:10b622c6cf6daa0a295be74c0e412ed20e10f91ae4c6f3ce6ff0c9c04f77cbf6 AS base

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
