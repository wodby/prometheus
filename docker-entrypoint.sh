#!/usr/bin/env bash

set -eo pipefail

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

_gotpl() {
  if [[ -f "/etc/gotpl/$1" ]]; then
    gotpl "/etc/gotpl/$1" >"$2"
  fi
}

process_templates() {
  _gotpl "prometheus.yml.tmpl" "/etc/prometheus/prometheus.yml"
}

sudo init_volumes

process_templates

sudo -E init_scripts

# shellcheck disable=SC2068
exec $@
