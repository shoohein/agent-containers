ARG BASE_IMAGE_REPO=agent/opencode
ARG BASE_IMAGE_TAG=latest
FROM ${BASE_IMAGE_REPO}:${BASE_IMAGE_TAG}

USER root
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ENV UV_TOOL_DIR=/opt/uv-tools
ENV UV_TOOL_BIN_DIR=/usr/local/bin
RUN uv tool install pre-commit==4.6.0

RUN apt-get update && apt-get install -y --no-install-recommends neovim build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER dev
