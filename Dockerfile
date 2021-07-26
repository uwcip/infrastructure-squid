FROM debian:bullseye-slim@sha256:9bfa0f4fb6d32116de4a6172f89a9266f7c73d1b8dae46f765bed703e541175e

# github metadata
LABEL org.opencontainers.image.source=https://github.com/uwcip/infrastructure-squid

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends squid squidclient && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
COPY entrypoint /entrypoint
RUN chmod +x /entrypoint

HEALTHCHECK --interval=1m --timeout=3s CMD squidclient -h localhost cache_object://localhost/counters || exit 1
ENTRYPOINT ["/entrypoint"]
