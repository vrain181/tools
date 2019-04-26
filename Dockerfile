ARG alpine_version

FROM alpine:${alpine_version:-3.9}

ARG ansible_version
ARG awscli_version
ARG terraform_version

ENV TERRAFORM_VERSION=${terraform_version:-0.11.3}
ENV ANSIBLE_VERSION=${ansible_version:-2.7.10}
ENV AWSCLI_VERSION=${awscli_version:-1.16.145}

ENV SCRIPT_MAIN='/tmp/main_script.sh'
ENV SCRIPT_LOCATION='/tmp/script/script.sh'

LABEL maintainer="salvatore181@gmail.com"

RUN set -xe && \
    apk update && \
    apk add --no-cache --purge -uU sudo curl ca-certificates openssh-client unzip\
            python-dev python py-pip libffi-dev openssl-dev build-base && \
    pip install --no-cache --upgrade ansible==${ANSIBLE_VERSION} awscli==${AWSCLI_VERSION} && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin

COPY script/ /tmp

RUN chmod +x ${SCRIPT_MAIN}

CMD ["sh +x ${SCRIPT_MAIN}", "/bin/sh"]