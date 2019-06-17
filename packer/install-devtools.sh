#!/bin/bash -

OS="linux"
ARCH="amd64"

GO_VERSION="1.12.5"
TERRAFORM_VERSION="0.11.14"

sudo apt install -y git unzip
git --version
if [ $? -ne 0 ]; then
  exit 1
fi

echo "=== install Golang ==="
wget https://dl.google.com/go/go${GO_VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.${OS}-${ARCH}.tar.gz
sudo echo 'export PATH=$PATH:/usr/local/go/bin' > /etc/profile.d/golang.sh
source /etc/profile.d/golang.sh
if [[ $(go version) != *${GO_VERSION}* ]]; then
  exit 1
fi

echo "=== install vs code ==="
wget -O code_amd64.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg --install code_amd64.deb
sudo apt install --assume-yes --fix-broken

echo "== install terraform ==="
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
unzip terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
rm -f terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
sudo mv terraform /usr/local/bin/
if [[ $(terraform version) != *${TERRAFORM_VERSION}* ]]; then
  exit 1
fi