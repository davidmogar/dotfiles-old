#!/usr/bin/env bash

readonly PACKAGES_FILE='packages'
readonly REPOSITORIES_SCRIPT='repositories.sh'

function install_packages {
  sudo apt-get update
  sudo apt-get -y upgrade

  while read package; do
    sudo apt-get -y install $package
  done < $PACKAGES_FILE

  sudo apt-get -y autoremove
}

function setup_repositories {
  source $REPOSITORIES_SCRIPT
}

setup_repositories
install_packages
