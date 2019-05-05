ARG alpine_version
ARG golang_version

FROM ${golang_version:-1.12}-alpine${alpine_version:-3.9}

ARG ansible_version
ARG awscli_version
ARG terraform_version

ENV TERRAFORM_VERSION=${terraform_version:-0.11.13}
ENV ANSIBLE_VERSION=${ansible_version:-2.7.10}
ENV AWSCLI_VERSION=${awscli_version:-1.16.145}

ENV SCRIPT_MAIN='/tmp/main_script.sh'
ENV SCRIPT_LOCATION='/tmp/script/script.sh'
ENV EC2_INI_PATH "/etc/ansible/ec2.ini"

LABEL maintainer="salvatore181@gmail.com"

COPY script/ /tmp
COPY ec2/ /etc/ansible/ec2


RUN set -xe && \
    apk update && \
    apk add --no-cache --purge -uU sudo curl ca-certificates openssh-client unzip\
            python-dev python py-pip libffi-dev openssl-dev git vim build-base && \
    pip install --no-cache --upgrade ansible==${ANSIBLE_VERSION} awscli==${AWSCLI_VERSION} && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    chmod +x ${SCRIPT_MAIN}

CMD sh +x ${SCRIPT_MAIN}; /bin/sh
