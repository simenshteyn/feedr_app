FROM ubuntu:16.04

USER root
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y gnupg2
RUN apt-get install -y wget
RUN apt-get install -y git

RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update

RUN apt-get install dart=2.7.*

ENV DART_SDK /usr/lib/dart
ENV PATH $DART_SDK/bin:/root/.pub-cache/bin:$PATH

RUN sh -c 'git clone https://github.com/stablekernel/aqueduct'

RUN sh -c 'sed -i 's/0.50.0/0.41.0/g' aqueduct/aqueduct/pubspec.yaml'

RUN pub global activate --source path aqueduct/aqueduct