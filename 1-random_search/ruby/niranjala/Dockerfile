FROM alpine:3.2
MAINTAINER Niranjala Senaratne <Niranjala.Senaratne@espn.com>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN mkdir /ns/app
WORKDIR /ns/app

COPY Gemfile /ns/app/
COPY Gemfile.lock /ns/app/
RUN bundle install

COPY . /ns/app