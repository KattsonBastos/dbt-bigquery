#!/usr/bin/env bash
build() {
  echo "Installing dbt-bigquery..."

  # install dbtbigquery
  pip install dbt-bigquery
  
  cp config_files/profiles.yml ~/.dbt/profiles.yml

  dbt --version
 
}

up() {

  echo "Enter the dbt project name you want"
  read dbt_project_name

  dbt init dbt_project_name
 
}


config() {

  export GOOGLE_APPLICATION_CREDENTIALS='/tmp/my_key.json'
 
}

case $1 in
  build)
    build
    ;;
  up)
    up
    ;;
  config)
    config
    ;;
  *)
    echo "Usage: $0 {build|up|config}"
    ;;
esac