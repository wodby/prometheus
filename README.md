# Prometheus Docker Container Image

[![Build docker image](https://github.com/wodby/prometheus/actions/workflows/workflow.yml/badge.svg)](https://github.com/wodby/prometheus/actions/workflows/workflow.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/prometheus.svg)](https://hub.docker.com/r/wodby/prometheus)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/prometheus.svg)](https://hub.docker.com/r/wodby/prometheus)

## Docker Images

For better reliability we release images with stability tags (`wodby/prometheus:3.13-X.X.X`) which correspond to [git tags](https://github.com/wodby/prometheus/releases). We strongly recommend using images only with stability tags.

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
