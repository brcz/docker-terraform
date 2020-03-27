FROM hashicorp/terraform

MAINTAINER marcelo correia <marcelo@correia.io>

ARG terraform_version="0.12.24"

RUN apk update

RUN set -ex && \
	apk add ca-certificates && update-ca-certificates && \
	apk add --no-cache --update \
        curl \
        unzip \
        bash \
        make \
        tree \
        tzdata \
        python \
        py-pip \
        python-dev \
        libffi-dev \
        build-base && \
    pip install --upgrade pip && \
    pip install awscli

RUN mkdir -p /app

RUN rm /var/cache/apk/*

WORKDIR /app

ENTRYPOINT ["terraform"]
