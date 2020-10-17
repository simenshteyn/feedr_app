FROM google/dart:2.7

WORKDIR /app
ADD pubspec.* /app/
RUN pub get --no-precompile
ADD . /app/
RUN pub get --offline --no-precompile

WORKDIR /app
EXPOSE 8080

ENTRYPOINT ["pub", "run", "aqueduct:aqueduct", "serve", "--port", "8080"]