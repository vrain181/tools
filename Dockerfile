ARG alpine_version

FROM alpine:${alpine_version:-3.9}

ARG ansible_version
ARG awscli_version
ARG terraform_version

ENV TERRAFORM_VERSION=${terraform_version:-0.11.3}
ENV ANSIBLE_VERSION=${ansible_version:-2.7.10}
ENV AWSCLI_VERSION=${awscli_version:-1.16.145}

LABEL maintainer="salvatore181@gmail.com"

RUN set -xe && \
    apk update && \

    ## install base
    apk add --no-cache --purge -uU sudo curl ca-certificates openssh-client unzip && \
    apk --update add --virtual .build-dependencies python-dev python py-pip libffi-dev openssl-dev build-base && \

    ## install ansible and awscli
    pip install --no-cache --upgrade ansible==${ANSIBLE_VERSION} awscli==${AWSCLI_VERSION} && \
    apk del --purge .build-dependencies && \

    ## install terraform
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin