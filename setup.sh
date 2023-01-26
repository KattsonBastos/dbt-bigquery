#!/usr/bin/env bash
build() {
  echo "Installing dbt-bigquery..."

  pip install dbt-bigquery
 
}

case $1 in
  build)
    build
    ;;
  *)
    echo "Usage: $0 {build}"
    ;;
esac