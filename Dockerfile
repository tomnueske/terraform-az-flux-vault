FROM hashicorp/terraform:light

RUN apk update && apk add bash py-pip curl

RUN curl -s https://fluxcd.io/install.sh | bash

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault


RUN apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make && \
    pip --no-cache-dir install -U pip && \
    pip --no-cache-dir install azure-cli && \
    apk del --purge build
