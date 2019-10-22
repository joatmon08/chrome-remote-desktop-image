#!/bin/bash -

set -o pipefail

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

OS="linux"
ARCH="amd64"

GO_VERSION="1.13.3"
TERRAFORM_VERSION="0.12.12"

sudo DEBIAN_FRONTEND=noninteractive apt install -y git unzip curl

echo "=== install Golang ==="
wget -nv https://dl.google.com/go/go${GO_VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.${OS}-${ARCH}.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ${HOME}/.profile

echo "=== install vs code ==="
wget -nv -O code_amd64.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo DEBIAN_FRONTEND=noninteractive apt install -yqq ./code_amd64.deb
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo DEBIAN_FRONTEND=noninteractive apt install -y -q code
sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes --fix-broken
code --install-extension ms-vscode.Go
code --install-extension eamodio.gitlens
code --install-extension stkb.rewrap
code --install-extension wholroyd.HCL

echo "== install terraform ==="
wget -nv https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
unzip terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
rm -f terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
sudo mv terraform /usr/local/bin/

echo "=== install docker ==="
sudo DEBIAN_FRONTEND=noninteractive apt install -y -q \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y -q docker-ce

sudo usermod -aG docker $USER