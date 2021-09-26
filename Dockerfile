ARG alpine_version
ARG golang_version

FROM golang:${golang_version:-1.17.1}-alpine${alpine_version:-3.14}

ARG ansible_version
ARG awscli_version
ARG terraform_version

ENV TERRAFORM_VERSION=${terraform_version:-1.0.7}
ENV ANSIBLE_VERSION=${ansible_version:-4.6.0}
ENV AWSCLI_VERSION=${awscli_version:-2.2.41}

ENV SCRIPT_MAIN='/tmp/main_script.sh'
ENV SCRIPT_LOCATION='/tmp/script/script.sh'

ENV EC2_INI_PATH "/etc/ansible/ec2.ini"
ENV AWS_DEFAULT_REGION "eu-central-1"
ENV EC2_REGION "${AWS_DEFAULT_REGION}"

LABEL maintainer="salvatore181@gmail.com"

COPY script/ /tmp
COPY ec2/ /etc/ansible/ec2

RUN set -xe && \
    apk update && \
    apk add --no-cache --purge -uU sudo curl ca-certificates openssh-client unzip\
            python3-dev python3 libffi-dev openssl-dev git vim build-base bash docker && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade boto boto3 pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    pip install --no-cache --upgrade ansible==${ANSIBLE_VERSION} molecule molecule[docker] && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip && \
    unzip awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip && \
    sh +x aws/install && \
    rm -f awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip && \
    rm -r aws/ && \
    rm -r /root/.cache && \
    chmod +x ${SCRIPT_MAIN}

CMD sh +x ${SCRIPT_MAIN}; /bin/sh
