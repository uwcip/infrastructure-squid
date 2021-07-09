FROM debian:bullseye-slim@sha256:0ed82c5d1414eacc0e97fda5656ed03cc06ab91c26cdeb54388403e440599a60

# github metadata
LABEL org.opencontainers.image.source=https://github.com/uwcip/infrastructure-squid

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && \
    apt-get install -y --no-install-recommends squid squidclient && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
COPY entrypoint /entrypoint
RUN chmod +x /entrypoint

HEALTHCHECK --interval=1m --timeout=3s CMD squidclient -h localhost cache_object://localhost/counters || exit 1
ENTRYPOINT ["/entrypoint"]
