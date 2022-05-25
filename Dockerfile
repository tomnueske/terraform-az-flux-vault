FROM hashicorp/terraform:1.1.7

ENV VAULT_VERSION 1.3.0
ENV VAULT_ZIP vault_${VAULT_VERSION}_linux_amd64.zip
ENV VAULT_URL https://releases.hashicorp.com/vault/$VAULT_VERSION/$VAULT_ZIP

RUN apk update && apk add bash py-pip curl

RUN apk update && apk add jq && \
    pip3 install yq

RUN curl -s https://fluxcd.io/install.sh | bash

RUN wget $VAULT_URL && \
    unzip $VAULT_ZIP && \
    mv vault /usr/local/bin/vault && \
    rm $VAULT_ZIP


RUN apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make && \
    pip --no-cache-dir install -U pip && \
    pip --no-cache-dir install azure-cli && \
    apk del --purge build
