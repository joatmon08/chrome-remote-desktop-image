FROM circleci/golang:1.13

ENV OS="linux"
ENV ARCH="amd64"
ENV TERRAFORM_VERSION="0.12.11"
ENV PACKER_VERSION="1.4.4"

RUN curl -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip
RUN unzip terraform.zip
RUN rm -f terraform.zip
RUN sudo mv terraform /usr/local/bin/

RUN curl -o packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_${OS}_${ARCH}.zip
RUN unzip packer.zip
RUN rm -f packer.zip
RUN sudo mv packer /usr/local/bin/