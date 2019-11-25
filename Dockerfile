FROM circleci/golang:1.13

ENV OS="linux"
ENV ARCH="amd64"
ENV TERRAFORM_VERSION="0.12.16"
ENV PACKER_VERSION="1.4.5"

RUN curl -s -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip \
    && unzip terraform.zip \
    && rm -f terraform.zip \
    && sudo mv terraform /usr/local/bin/

RUN curl -s -o packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_${OS}_${ARCH}.zip \
    && unzip packer.zip \
    && rm -f packer.zip \
    && sudo mv packer /usr/local/bin/

RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
    && sudo apt-get update -y \
    && sudo apt-get install -y google-cloud-sdk \
    && sudo apt-get clean

RUN git clone https://github.com/joatmon08/tf-helper.git \
    && cd tf-helper/tfh/bin \
    && sudo ln -s $PWD/tfh /usr/local/bin/tfh