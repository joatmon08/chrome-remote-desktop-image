#!/bin/bash -

if [ ! -d "/opt/google/chrome-remote-desktop" ] 
then
    echo "Directory /opt/google/chrome-remote-desktop DOES NOT exist." 
    exit 1
fi

git --version
if [ $? -ne 0 ]; then
  echo "Git failed to install"
  exit 1
fi

code --version --user-data-dir="~/.vscode-root"
if [ $? -ne 0 ]; then
  echo "VS Code failed to install"
  exit 1
fi

if [[ $(terraform version) != *"0.12"* ]]; then
  echo "Terraform does not have correct version"
  exit 1
fi

if [[ $(docker version --format '{{.Client.Version}}') != *"19.03"* ]]; then
  echo "Docker does not have correct version"
  exit 1
fi

source ${HOME}/.profile
if [[ $(go version) != *"1.13"* ]]; then
  echo "Golang does not have correct version"
  exit 1
fi