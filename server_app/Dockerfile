FROM google/dart:2.7

WORKDIR /app
ADD pubspec.* /app/
RUN pub get --no-precompile
ADD . /app/
RUN pub get --offline --no-precompile

WORKDIR /app
EXPOSE 8080

RUN pub run aqueduct build

ENTRYPOINT ["./server_app.aot", "--port", "8080", "--isolates", "4"]
