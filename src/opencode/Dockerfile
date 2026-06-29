# syntax=docker/dockerfile:1
ARG BASE_IMAGE_REPO=agent/opencode
ARG BASE_IMAGE_TAG=latest

FROM ${BASE_IMAGE_REPO}:${BASE_IMAGE_TAG}

USER root
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ENV UV_TOOL_DIR=/opt/uv-tools
ENV UV_TOOL_BIN_DIR=/usr/local/bin
 RUN uv tool install pre-commit==4.6.0

# Install Docker CE + buildx from Docker's official apt repo
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /tmp/docker.gpg \
    && rm -f /etc/apt/keyrings/docker.gpg \
    && gpg --batch --dearmor -o /etc/apt/keyrings/docker.gpg /tmp/docker.gpg \
    && rm /tmp/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" \
        >/etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        docker-ce docker-buildx-plugin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create docker group and grant users access
RUN groupadd -f docker \
    && usermod -aG docker agent 2>/dev/null || true \
    && usermod -aG docker dev 2>/dev/null || true

# DinD entrypoint wrapper: starts dockerd before chaining to base entrypoint
COPY --chmod=0755 dind-entrypoint.sh /usr/local/bin/dind-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/dind-entrypoint.sh"]
CMD ["opencode"]
USER dev
