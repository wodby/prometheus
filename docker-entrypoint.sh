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
  _gotpl "prometheus.yaml.tmpl" "/etc/prometheus/prometheus.yaml"
  _gotpl "prometheus-init.sh.tmpl" "/usr/local/bin/prometheus-init"
}

sudo init_volumes

process_templates

sudo init_scripts

# shellcheck disable=SC2068
exec $@
