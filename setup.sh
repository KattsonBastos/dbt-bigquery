#!/usr/bin/env bash
build() {
  echo "Installing dbt-bigquery..."

  # install dbtbigquery
  pip install dbt-bigquery
  
  # making a folder to copy the profile file
  mkdir ~/.dbt

  cp config_files/profiles.yml ~/.dbt/profiles.yml
  
  # printing version to check whether or not it was installed
  dbt --version
 
}

up() {

  echo "Enter the dbt project name you want"
  read dbt_project_name

  dbt init dbt_project_name
 
}


config() {

  echo "To do.."
 
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