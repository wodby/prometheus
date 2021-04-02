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

  for f in /etc/gotpl/alerts/*.tmpl; do
    _gotpl "alerts/${f##*/}" "/etc/prometheus/alerts/$(basename "${f%.tmpl}")"
  done

  for f in /etc/gotpl/rules/*.tmpl; do
    _gotpl "rules/${f##*/}" "/etc/prometheus/rules/$(basename "${f%.tmpl}")"
  done
}

sudo init_volumes

mkdir -p /etc/prometheus/alerts
mkdir -p /etc/prometheus/rules

process_templates

sudo init_scripts

# shellcheck disable=SC2068
exec $@
