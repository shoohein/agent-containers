ARG BASE_IMAGE_REPO=agent/opencode
ARG BASE_IMAGE_TAG=latest
ARG DOCKER_CLI_VERSION=26.1.4

FROM ${BASE_IMAGE_REPO}:${BASE_IMAGE_TAG}

ARG DOCKER_CLI_VERSION
USER root
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ENV UV_TOOL_DIR=/opt/uv-tools
ENV UV_TOOL_BIN_DIR=/usr/local/bin
 RUN uv tool install pre-commit==4.6.0

# Install Docker Engine (DinD) via Debian apt package
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI (static binary — Debian's docker.io package is daemon-only)
RUN curl -fsSL "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLI_VERSION}.tgz" \
    | tar -xz -C /usr/bin --strip-components=1 docker/docker \
    && chmod +x /usr/bin/docker

# Create docker group and grant users access
RUN groupadd -f docker \
    && usermod -aG docker agent 2>/dev/null || true \
    && usermod -aG docker dev 2>/dev/null || true

# DinD entrypoint wrapper: starts dockerd before chaining to base entrypoint
COPY dind-entrypoint.sh /usr/local/bin/dind-entrypoint.sh
RUN chmod +x /usr/local/bin/dind-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/dind-entrypoint.sh"]
CMD ["opencode"]
USER dev
