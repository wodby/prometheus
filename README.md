# Prometheus Docker Container Image

[![Build docker image](https://github.com/wodby/prometheus/actions/workflows/workflow.yml/badge.svg)](https://github.com/wodby/prometheus/actions/workflows/workflow.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/prometheus.svg)](https://hub.docker.com/r/wodby/prometheus)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/prometheus.svg)](https://hub.docker.com/r/wodby/prometheus)

## Docker Images

Use image revision tags such as `wodby/prometheus:3.13-rN` to select a Wodby image revision.
Major and minor tags use the repository release number. Full-version tags such as
`wodby/prometheus:3.13.3-r0` start at `r0` for each exact upstream version.
Every published versioned revision tag has a matching annotated Git tag pointing to its release commit.
Existing tags remain available after support for their major or minor version ends.
See [release tags](https://github.com/wodby/prometheus/tags) for available revisions and the [image revision policy](https://github.com/wodby/images#image-revisions) for upgrade guidance.
Previously published image tags remain available.

Overview:

- All images are based on Alpine Linux
- Prometheus binaries are copied from [prom/prometheus](https://github.com/prometheus/prometheus)
- This image tracks the latest Prometheus LTS version
- [GitHub actions builds](https://github.com/wodby/prometheus/actions)
- [Docker Hub](https://hub.docker.com/r/wodby/prometheus)

[_(Dockerfile)_]: https://github.com/wodby/prometheus/tree/main/Dockerfile

Supported tags and respective `Dockerfile` links:

- `3.13`, `3`, `latest` [_(Dockerfile)_]

All images built for `linux/amd64` and `linux/arm64`.
