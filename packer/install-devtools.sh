#!/bin/bash -

OS="linux"
ARCH="amd64"

GO_VERSION="1.12.6"
TERRAFORM_VERSION="0.12.2"

sudo apt install -y git unzip
git --version
if [ $? -ne 0 ]; then
  exit 1
fi

echo "=== install Golang ==="
wget https://dl.google.com/go/go${GO_VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.${OS}-${ARCH}.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ${HOME}/.profile
source ${HOME}/.profile
if [[ $(go version) != *${GO_VERSION}* ]]; then
  exit 1
fi

echo "=== install vs code ==="
wget -O code_amd64.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo apt install -y ./code_amd64.deb
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install -y apt-transport-https
sudo apt-get update -y
sudo apt-get install -y code
sudo apt install --assume-yes --fix-broken
code --version
if [ $? -ne 0 ]; then
  exit 1
fi
code --install-extension ms-vscode.Go
code --install-extension eamodio.gitlens
code --install-extension stkb.rewrap
code --install-extension wholroyd.HCL


echo "== install terraform ==="
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
unzip terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
rm -f terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
sudo mv terraform /usr/local/bin/
if [[ $(terraform version) != *${TERRAFORM_VERSION}* ]]; then
  exit 1
fi