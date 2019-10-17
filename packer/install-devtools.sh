#!/bin/bash -

OS="linux"
ARCH="amd64"

GO_VERSION="1.12.10"
TERRAFORM_VERSION="0.12.10"

sudo apt install -y git unzip
git --version
if [ $? -ne 0 ]; then
  echo "Git failed to install"
  exit 1
fi

echo "=== install Golang ==="
wget https://dl.google.com/go/go${GO_VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.${OS}-${ARCH}.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ${HOME}/.profile
source ${HOME}/.profile
if [[ $(go version) != *${GO_VERSION}* ]]; then
  echo "Golang failed to install"
  exit 1
fi

echo "=== install vs code ==="
wget -O code_amd64.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo apt install -y ./code_amd64.deb
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install -y apt-transport-https
sudo apt update -y
sudo apt install -y code
sudo apt install --assume-yes --fix-broken
code --version --user-data-dir="~/.vscode-root"
if [ $? -ne 0 ]; then
  echo "VS Code failed to install"
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
  echo "Terraform failed to install"
  exit 1
fi

echo "=== install docker ==="
sudo apt install -yqq \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt update -yqq
sudo apt install -yqq docker-ce
docker version
if [ $? -ne 0 ]; then
  echo "Docker failed to install"
  exit 1
fi

echo "=== install consul k8s dev ==="
curl http://consul-k8s.demo.gs/install.sh | bash

echo "=== install lastpass cli ==="
apt --no-install-recommends -yqq install \
  bash-completion \
  build-essential \
  cmake \
  libcurl3  \
  libcurl3-openssl-dev  \
  libssl1.0 \
  libssl1.0-dev \
  libxml2 \
  libxml2-dev  \
  pkg-config \
  ca-certificates \
  xclip
git clone https://github.com/lastpass/lastpass-cli.git
cd lastpass-cli
mkdir -p /root/.config/lpass
make
sudo make install
lpass --version
if [ $? -ne 0 ]; then
  echo "LastPass CLI did not install"
  exit 1
fi